from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.db.models import Q
from ..models import Student, Subject, Attendance
from ..forms import DateFilterForm, SubjectFilterForm

@login_required
def view_attendance_report(request):
    user = request.user
    context = {}
    
    if user.is_superuser:
        subjects = Subject.objects.all()
        if request.method == 'POST':
            form = DateFilterForm(request.POST)
            subject_form = SubjectFilterForm(data=request.POST)
            
            if form.is_valid() and subject_form.is_valid():
                selected_date = form.cleaned_data['date']
                selected_subject = subject_form.cleaned_data['subject']
                
                query = Q(date=selected_date)
                if selected_subject:
                    query &= Q(subject=selected_subject)
                
                attendance_records = Attendance.objects.filter(query).select_related('student', 'subject')
                context['attendance_records'] = attendance_records
                context['selected_date'] = selected_date
                context['selected_subject'] = selected_subject
        else:
            form = DateFilterForm()
            subject_form = SubjectFilterForm()
        
        context['form'] = form
        context['subject_form'] = subject_form
        context['subjects'] = subjects
        
    elif hasattr(user, 'teacher'):
        teacher = user.teacher
        subjects = Subject.objects.filter(teacher=teacher)
        
        if request.method == 'POST':
            form = DateFilterForm(request.POST)
            subject_form = SubjectFilterForm(teacher, data=request.POST)
            
            if form.is_valid() and subject_form.is_valid():
                selected_date = form.cleaned_data['date']
                selected_subject = subject_form.cleaned_data['subject']
                
                query = Q(date=selected_date, subject__teacher=teacher)
                if selected_subject:
                    query &= Q(subject=selected_subject)
                
                attendance_records = Attendance.objects.filter(query).select_related('student', 'subject')
                context['attendance_records'] = attendance_records
                context['selected_date'] = selected_date
                context['selected_subject'] = selected_subject
        else:
            form = DateFilterForm()
            subject_form = SubjectFilterForm(teacher)
        
        context['form'] = form
        context['subject_form'] = subject_form
        context['subjects'] = subjects
        
    elif hasattr(user, 'student'):
        student = user.student
        subjects = student.subjects.all()
        
        if request.method == 'POST':
            form = DateFilterForm(request.POST)
            subject_form = SubjectFilterForm(data=request.POST)
            
            if form.is_valid() and subject_form.is_valid():
                selected_date = form.cleaned_data['date']
                selected_subject = subject_form.cleaned_data['subject']
                
                query = Q(student=student, date=selected_date)
                if selected_subject:
                    query &= Q(subject=selected_subject)
                
                attendance_records = Attendance.objects.filter(query).select_related('subject')
                context['attendance_records'] = attendance_records
                context['selected_date'] = selected_date
                context['selected_subject'] = selected_subject
        else:
            form = DateFilterForm()
            subject_form = SubjectFilterForm()
            subject_form.fields['subject'].queryset = subjects
        
        context['form'] = form
        context['subject_form'] = subject_form
        context['subjects'] = subjects
    
    context['user_type'] = 'admin' if user.is_superuser else 'teacher' if hasattr(user, 'teacher') else 'student'
    return render(request, 'attendance_report.html', context)

@login_required
def student_attendance_history(request, student_id=None):
    user = request.user
    
    if student_id is None and hasattr(user, 'student'):
        student_id = user.student.id
    
    if not (user.is_superuser or hasattr(user, 'teacher') or (hasattr(user, 'student') and user.student.id == student_id)):
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
    
    if hasattr(user, 'student') and (student_id is None or user.student.id == student_id):
        student = user.student
    else:
        student = get_object_or_404(Student, id=student_id)
    
    context = {'student': student}
    
    if request.method == 'POST':
        form = DateFilterForm(request.POST)
        
        if hasattr(user, 'teacher') and not user.is_superuser:
            subject_form = SubjectFilterForm(user.teacher, data=request.POST)
        else:
            subject_form = SubjectFilterForm(data=request.POST)
            if hasattr(user, 'student'):
                subject_form.fields['subject'].queryset = user.student.subjects.all()
        
        if form.is_valid() and subject_form.is_valid():
            selected_date = form.cleaned_data['date']
            selected_subject = subject_form.cleaned_data['subject']
            
            query = Q(student=student)
            
            if selected_date:
                query &= Q(date=selected_date)
            
            if selected_subject:
                query &= Q(subject=selected_subject)
            
            if hasattr(user, 'teacher') and not user.is_superuser:
                query &= Q(subject__teacher=user.teacher)
            
            attendance_records = Attendance.objects.filter(query).select_related('subject').order_by('-date')
            context['attendance_records'] = attendance_records
            context['selected_date'] = selected_date
            context['selected_subject'] = selected_subject
    else:
        form = DateFilterForm()
        
        if hasattr(user, 'teacher') and not user.is_superuser:
            subject_form = SubjectFilterForm(user.teacher)
        else:
            subject_form = SubjectFilterForm()
            if hasattr(user, 'student'):
                subject_form.fields['subject'].queryset = user.student.subjects.all()
        
        attendance_records = Attendance.objects.filter(
            student=student
        ).select_related('subject').order_by('-date')[:10]
        
        context['attendance_records'] = attendance_records
    
    context['form'] = form
    context['subject_form'] = subject_form
    context['user_type'] = 'admin' if user.is_superuser else 'teacher' if hasattr(user, 'teacher') else 'student'
    
    return render(request, 'student_attendance_history.html', context)
