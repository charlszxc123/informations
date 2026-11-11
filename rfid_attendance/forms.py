from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm, PasswordChangeForm
from .models import Teacher, Student, Subject, Attendance, AttendanceSession

class LoginForm(forms.Form):
    username = forms.CharField(max_length=150, required=True, widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Username'}))
    password = forms.CharField(max_length=128, required=True, widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': 'Password'}))

class TeacherForm(forms.ModelForm):
    password = forms.CharField(max_length=128, required=False, widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    
    class Meta:
        model = Teacher
        fields = ['teacher_id', 'full_name', 'email', 'phone']
        widgets = {
            'taeacher_id': forms.TextInput(attrs={'class': 'form-control'}),
            'full_name': forms.TextInput(attrs={'class': 'form-control'}),
            'email': forms.EmailInput(attrs={'class': 'form-control'}),
            'phone': forms.TextInput(attrs={'class': 'form-control'}),
        }
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.instance and self.instance.pk:
            self.fields['password'].required = False
            self.fields['password'].help_text = "Leave empty to keep current password"
            self.fields['teacher_id'].widget.attrs['readonly'] = True
        else:
            self.fields['password'].required = True
            
    def save(self, commit=True):
        teacher_data = self.cleaned_data
        instance = self.instance
        
        if instance and instance.pk:
            user = instance.user
            
            if teacher_data.get('password'):
                user.set_password(teacher_data['password'])
            
            user.email = teacher_data['email']
            user.first_name = teacher_data['full_name'].split()[0]
            last_names = teacher_data['full_name'].split()[1:] if len(teacher_data['full_name'].split()) > 1 else ['']
            user.last_name = ' '.join(last_names)
            
            if commit:
                user.save()
            
            instance.full_name = teacher_data['full_name']
            instance.email = teacher_data['email']
            instance.phone = teacher_data['phone']
            
            if commit:
                instance.save()
                
            return instance
            
        else:
            user = User.objects.create_user(
                username=teacher_data['teacher_id'],
                email=teacher_data['email'],
                password=teacher_data['password'],
                first_name=teacher_data['full_name'].split()[0],
                last_name=' '.join(teacher_data['full_name'].split()[1:]) if len(teacher_data['full_name'].split()) > 1 else '',
            )
            
            teacher = Teacher(
                user=user,
                teacher_id=teacher_data['teacher_id'],
                full_name=teacher_data['full_name'],
                email=teacher_data['email'],
                phone=teacher_data['phone'],
            )
            
            if commit:
                teacher.save()
            
            return teacher

class StudentForm(forms.ModelForm):
    password = forms.CharField(max_length=128, required=False, widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    
    class Meta:
        model = Student
        fields = ['student_id', 'full_name', 'email', 'rfid_card']
        widgets = {
            'student_id': forms.TextInput(attrs={'class': 'form-control'}),
            'full_name': forms.TextInput(attrs={'class': 'form-control'}),
            'email': forms.EmailInput(attrs={'class': 'form-control'}),
            'rfid_card': forms.TextInput(attrs={'class': 'form-control'}),
        }
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.instance and self.instance.pk:
            self.fields['password'].required = False
            self.fields['password'].help_text = "Leave empty to keep current password"
            self.fields['student_id'].widget.attrs['readonly'] = True
        else:
            self.fields['password'].required = True
            
    def save(self, commit=True):
        student_data = self.cleaned_data
        instance = self.instance
        
        if instance and instance.pk:
            user = instance.user
            
            if student_data.get('password'):
                user.set_password(student_data['password'])
            
            user.email = student_data['email']
            user.first_name = student_data['full_name'].split()[0]
            last_names = student_data['full_name'].split()[1:] if len(student_data['full_name'].split()) > 1 else ['']
            user.last_name = ' '.join(last_names)
            
            if commit:
                user.save()
            
            instance.full_name = student_data['full_name']
            instance.email = student_data['email']
            instance.rfid_card = student_data['rfid_card']
            
            if commit:
                instance.save()
                
            return instance
            
        else:
            user = User.objects.create_user(
                username=student_data['student_id'],
                email=student_data['email'],
                password=student_data['password'],
                first_name=student_data['full_name'].split()[0],
                last_name=' '.join(student_data['full_name'].split()[1:]) if len(student_data['full_name'].split()) > 1 else '',
            )
            
            student = Student(
                user=user,
                student_id=student_data['student_id'],
                full_name=student_data['full_name'],
                email=student_data['email'],
                rfid_card=student_data['rfid_card'],
            )
            
            if commit:
                student.save()
            
            return student

class SubjectForm(forms.ModelForm):
    students = forms.ModelMultipleChoiceField(
        queryset=Student.objects.all(),
        widget=forms.CheckboxSelectMultiple,
        required=False
    )
    
    class Meta:
        model = Subject
        fields = ['code', 'name', 'teacher', 'students', 'schedule_start_time', 'schedule_end_time', 'schedule_day']
        widgets = {
            'code': forms.TextInput(attrs={'class': 'form-control'}),
            'name': forms.TextInput(attrs={'class': 'form-control'}),
            'teacher': forms.Select(attrs={'class': 'form-control'}),
            'schedule_start_time': forms.TimeInput(attrs={'class': 'form-control', 'type': 'time'}),
            'schedule_end_time': forms.TimeInput(attrs={'class': 'form-control', 'type': 'time'}),
            'schedule_day': forms.Select(attrs={'class': 'form-control'}),
        }
    
    def clean(self):
        cleaned_data = super().clean()
        start_time = cleaned_data.get('schedule_start_time')
        end_time = cleaned_data.get('schedule_end_time')
        
        if start_time and end_time and start_time >= end_time:
            self.add_error('schedule_end_time', "End time must be after start time")
            
        return cleaned_data

class AttendanceSessionForm(forms.ModelForm):
    class Meta:
        model = AttendanceSession
        fields = ['subject', 'date']
        widgets = {
            'subject': forms.Select(attrs={'class': 'form-control'}),
            'date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
        }

class PasswordResetForm(forms.Form):
    username = forms.CharField(max_length=150, required=True, widget=forms.TextInput(attrs={'class': 'form-control'}))
    new_password = forms.CharField(max_length=128, required=True, widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    confirm_password = forms.CharField(max_length=128, required=True, widget=forms.PasswordInput(attrs={'class': 'form-control'}))
    
    def clean(self):
        cleaned_data = super().clean()
        new_password = cleaned_data.get('new_password')
        confirm_password = cleaned_data.get('confirm_password')
        
        if new_password and confirm_password and new_password != confirm_password:
            raise forms.ValidationError("Passwords do not match")
        
        return cleaned_data

class DateFilterForm(forms.Form):
    date = forms.DateField(widget=forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}))

class SubjectFilterForm(forms.Form):
    subject = forms.ModelChoiceField(
        queryset=Subject.objects.all(),
        widget=forms.Select(attrs={'class': 'form-control'}),
        required=False
    )
    
    def __init__(self, teacher=None, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if teacher:
            self.fields['subject'].queryset = Subject.objects.filter(teacher=teacher)

class ChangePasswordForm(forms.Form):
    current_password = forms.CharField(
        max_length=128, 
        required=True, 
        widget=forms.PasswordInput(attrs={'class': 'form-control'})
    )
    new_password = forms.CharField(
        max_length=128, 
        required=True, 
        widget=forms.PasswordInput(attrs={'class': 'form-control'})
    )
    confirm_password = forms.CharField(
        max_length=128, 
        required=True, 
        widget=forms.PasswordInput(attrs={'class': 'form-control'})
    )
    
    def __init__(self, user=None, *args, **kwargs):
        self.user = user
        super().__init__(*args, **kwargs)
    
    def clean_current_password(self):
        current_password = self.cleaned_data.get('current_password')
        if self.user and not self.user.check_password(current_password):
            raise forms.ValidationError("Current password is incorrect")
        return current_password
    
    def clean(self):
        cleaned_data = super().clean()
        new_password = cleaned_data.get('new_password')
        confirm_password = cleaned_data.get('confirm_password')
        
        if new_password and confirm_password and new_password != confirm_password:
            raise forms.ValidationError("New passwords do not match")
        
        return cleaned_data 