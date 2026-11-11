from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.contrib.auth.models import User
from ..models import Teacher, Student, Subject
from ..forms import TeacherForm, StudentForm, SubjectForm, PasswordResetForm, ChangePasswordForm


def has_conflict(teacher, day, start_time, end_time, exclude_id=None):
    subjects = Subject.objects.filter(teacher=teacher, schedule_day=day)
    if exclude_id:
        subjects = subjects.exclude(id=exclude_id)

    for subject in subjects:
        if (start_time < subject.schedule_end_time and end_time > subject.schedule_start_time):
            return True
    return False


@login_required
def manage_teachers(request):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    teachers = Teacher.objects.all()
    
    return render(request, 'admin/teachers.html', {'teachers': teachers})


@login_required
def add_teacher(request):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    if request.method == 'POST':
        form = TeacherForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Teacher added successfully')
            return redirect('manage_teachers')
    else:
        form = TeacherForm()
        
    return render(request, 'admin/teacher_form.html', {'form': form, 'title': 'Add Teacher'})


@login_required
def edit_teacher(request, teacher_id):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    teacher = get_object_or_404(Teacher, id=teacher_id)
    
    if request.method == 'POST':
        form = TeacherForm(request.POST, instance=teacher)
        if form.is_valid():
            form.save()
            messages.success(request, 'Teacher updated successfully')
            return redirect('manage_teachers')
    else:
        form = TeacherForm(instance=teacher)
        
    return render(request, 'admin/teacher_form.html', {'form': form, 'title': 'Edit Teacher'})


@login_required
def delete_teacher(request, teacher_id):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    teacher = get_object_or_404(Teacher, id=teacher_id)
    user = teacher.user
    
    teacher.delete()
    user.delete()
    
    messages.success(request, 'Teacher deleted successfully')
    return redirect('manage_teachers')


@login_required
def manage_students(request):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    students = Student.objects.all()
    
    return render(request, 'admin/students.html', {'students': students})


@login_required
def add_student(request):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    if request.method == 'POST':
        form = StudentForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, 'Student added successfully')
            return redirect('manage_students')
    else:
        form = StudentForm()
        
    return render(request, 'admin/student_form.html', {'form': form, 'title': 'Add Student'})


@login_required
def edit_student(request, student_id):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    student = get_object_or_404(Student, id=student_id)
    
    if request.method == 'POST':
        form = StudentForm(request.POST, instance=student)
        if form.is_valid():
            form.save()
            messages.success(request, 'Student updated successfully')
            return redirect('manage_students')
    else:
        form = StudentForm(instance=student)
        
    return render(request, 'admin/student_form.html', {'form': form, 'title': 'Edit Student'})


@login_required
def delete_student(request, student_id):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    student = get_object_or_404(Student, id=student_id)
    user = student.user
    
    student.delete()
    user.delete()
    
    messages.success(request, 'Student deleted successfully')
    return redirect('manage_students')


@login_required
def manage_subjects(request):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    subjects = Subject.objects.all()
    
    return render(request, 'admin/subjects.html', {'subjects': subjects})


@login_required
def add_subject(request):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    if request.method == 'POST':
        form = SubjectForm(request.POST)
        if form.is_valid():
            teacher = form.cleaned_data['teacher']
            day = form.cleaned_data['schedule_day']  
            start_time = form.cleaned_data['schedule_start_time']
            end_time = form.cleaned_data['schedule_end_time']
            
            if has_conflict(teacher, day, start_time, end_time):
                messages.error(request, 'Schedule conflict detected for the selected teacher.')
            else:
                form.save()
                messages.success(request, 'Subject added successfully')
                return redirect('manage_subjects')
    else:
        form = SubjectForm()
        
    return render(request, 'admin/subject_form.html', {'form': form, 'title': 'Add Subject'})


@login_required
def edit_subject(request, subject_id):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    subject = get_object_or_404(Subject, id=subject_id)
    
    if request.method == 'POST':
        form = SubjectForm(request.POST, instance=subject)
        if form.is_valid():
            teacher = form.cleaned_data['teacher']
            day = form.cleaned_data['schedule_day']
            start_time = form.cleaned_data['schedule_start_time']
            end_time = form.cleaned_data['schedule_end_time']
            
            if has_conflict(teacher, day, start_time, end_time, exclude_id=subject.id):
                messages.error(request, 'Schedule conflict detected for the selected teacher.')
            else:
                form.save()
                messages.success(request, 'Subject updated successfully')
                return redirect('manage_subjects')
    else:
        form = SubjectForm(instance=subject)
        
    return render(request, 'admin/subject_form.html', {'form': form, 'title': 'Edit Subject'})


@login_required
def delete_subject(request, subject_id):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    subject = get_object_or_404(Subject, id=subject_id)
    subject.delete()
    
    messages.success(request, 'Subject deleted successfully')
    return redirect('manage_subjects')


@login_required
def reset_password(request):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    if request.method == 'POST':
        form = PasswordResetForm(request.POST)
        if form.is_valid():
            username = form.cleaned_data['username']
            new_password = form.cleaned_data['new_password']
            
            try:
                user = User.objects.get(username=username)
                user.set_password(new_password)
                user.save()
                messages.success(request, 'Password reset successful')
                return redirect('dashboard')
            except User.DoesNotExist:
                messages.error(request, 'User not found')
    else:
        form = PasswordResetForm()
        
    return render(request, 'admin/reset_password.html', {'form': form})


@login_required
def change_admin_password(request):
    if not request.user.is_superuser:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
    
    if request.method == 'POST':
        form = ChangePasswordForm(user=request.user, data=request.POST)
        if form.is_valid():
            new_password = form.cleaned_data['new_password']
            request.user.set_password(new_password)
            request.user.save()
            messages.success(request, 'Your password has been changed successfully.')
            return redirect('dashboard')
    else:
        form = ChangePasswordForm(user=request.user)
    
    return render(request, 'admin/change_password.html', {'form': form})
