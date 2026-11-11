from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.http import JsonResponse
from django.utils import timezone
import datetime
from ..models import Subject, Student, Attendance, AttendanceSession
import pytz
from django.core.exceptions import ValidationError

def get_current_day():
    """Utility function to get the current day name"""
    current_time = timezone.localtime(timezone.now())
    
    day_name = current_time.strftime('%A')
    
    print(f"Raw server time: {timezone.now()}")
    print(f"Localized time: {current_time}")
    print(f"Date from localized time: {current_time.date()}")
    print(f"Day name from localized time: {day_name}")
    
    return day_name

@login_required
def teacher_subjects(request):
    """View subjects assigned to a teacher"""
    if not hasattr(request.user, 'teacher'):
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
    
    storage = messages.get_messages(request)
    for message in storage:
        pass
    
    teacher = request.user.teacher
    subjects = Subject.objects.filter(teacher=teacher)
    current_day = get_current_day()
    
    print(f"Teacher subjects view - Current day: {current_day}")
    
    return render(request, 'teacher/subjects.html', {
        'subjects': subjects,
        'current_day': current_day
    })

def student_subjects(request):
    """View subjects the logged-in student is enrolled in"""
    if not hasattr(request.user, 'student'):
        messages.error(request, 'Permission denied.')
        return redirect('dashboard')
    
    student = request.user.student
    subjects = student.subjects.all() 
    
    return render(request, 'student/student_dashboard.html', {
        'subjects': subjects
    })

@login_required
def subject_students(request, subject_id):
    """View students enrolled in a specific subject"""
    if not hasattr(request.user, 'teacher'):
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    subject = get_object_or_404(Subject, id=subject_id)
    
    if subject.teacher != request.user.teacher:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    students = subject.students.all()

    return render(request, 'teacher/subject_students.html', {
        'subject': subject,
        'students': students,
    })

def get_or_create_attendance_session(subject, date, current_time=None):
    """Helper function to safely get or create an attendance session"""
    if current_time is None:
        current_time = timezone.localtime(timezone.now()).time()
        
    try:
        # Try to get an existing session
        session = AttendanceSession.objects.get(
            subject=subject,
            date=date,
            is_active=True
        )
        print(f"Found existing session ID: {session.id}")
        return session, False
    except AttendanceSession.DoesNotExist:
        # Don't create a session here, just return None
        return None, True

@login_required
def start_attendance(request, subject_id):
    """Start an attendance session for a subject"""
    if not hasattr(request.user, 'teacher'):
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    subject = get_object_or_404(Subject, id=subject_id)
    
    # Ensure the teacher owns this subject
    if subject.teacher != request.user.teacher:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
    
    # Track which messages we've already added to avoid duplicates
    added_messages = set()
    
    # Check time and date requirements first
    today = timezone.localtime(timezone.now()).date()
    current_time = timezone.localtime(timezone.now()).time()
    start_time = subject.schedule_start_time
    end_time = subject.schedule_end_time
    
    # Get current time as datetime for comparison
    current_datetime = datetime.datetime.combine(today, current_time)
    start_datetime = datetime.datetime.combine(today, start_time)
    end_datetime = datetime.datetime.combine(today, end_time)
    
    # Debug the time comparison
    print(f"Current time: {current_time}")
    print(f"Start time: {start_time}")
    print(f"End time: {end_time}")
    print(f"Current < Start: {current_datetime < start_datetime}")
    print(f"Current > End: {current_datetime > end_datetime}")
    
    # Check if there's already an active session for this subject today
    print(f"Checking for active sessions on date: {today}")
    
    # Use the helper function to check for existing session
    existing_session, is_new = get_or_create_attendance_session(subject, today)
    
    # If session already exists, just redirect to it
    if existing_session and not existing_session.is_active:
        messages.warning(request, f'The attendance session for this subject today has already ended.')
        return redirect('teacher_subjects')
    elif existing_session:
        return redirect('manage_attendance', session_id=existing_session.id)
    
    # Get current day with better timezone handling
    current_day = get_current_day()
    
    # Debug the day detection
    print(f"Current datetime in start_attendance: {timezone.localtime(timezone.now())}")
    print(f"Detected day in start_attendance: {current_day}")
    print(f"Subject scheduled day: {subject.schedule_day}")
    
    # Verify the current day matches the scheduled day
    msg_key = f'day_{subject.schedule_day}'
    if current_day != subject.schedule_day and msg_key not in added_messages:
        messages.error(request, f'Attendance can only be taken on {subject.schedule_day}. Today is {current_day}.')
        added_messages.add(msg_key)
        return redirect('teacher_subjects')
    
    # Strictly enforce time window - must be between start time and end time
    msg_key = f'before_start_time_{start_time}'
    if current_datetime < start_datetime and msg_key not in added_messages:
        messages.error(request, f'Attendance can only be started at or after the scheduled start time ({start_time.strftime("%I:%M %p")}).')
        added_messages.add(msg_key)
        return redirect('teacher_subjects')
    
    msg_key = f'after_end_time_{end_time}'
    if current_datetime > end_datetime and msg_key not in added_messages:
        messages.error(request, f'Attendance cannot be started after the class end time ({end_time.strftime("%I:%M %p")}).')
        added_messages.add(msg_key)
        return redirect('teacher_subjects')
    
    # If we get here, all checks passed. Create a new attendance session
    try:
        # Final verification: check time again right before creating the session
        current_time = timezone.localtime(timezone.now()).time()
        current_datetime = datetime.datetime.combine(today, current_time)
        
        msg_key = f'final_check_before_start_time_{start_time}'
        if current_datetime < start_datetime and msg_key not in added_messages:
            messages.error(request, f'Time check failed: Current time {current_time.strftime("%H:%M:%S")} is before the scheduled start time {start_time.strftime("%H:%M:%S")}')
            added_messages.add(msg_key)
            return redirect('teacher_subjects')
        
        session = AttendanceSession.objects.create(
            subject=subject,
            date=today,
            start_time=current_time,
            is_active=True
        )
        
        # Create attendance records for all students in this subject
        # But first check if records already exist for today
        existing_students = Attendance.objects.filter(
            subject=subject,
            date=today
        ).values_list('student_id', flat=True)
        
        # Only create records for students that don't have one yet
        for student in subject.students.all():
            if student.id not in existing_students:
                try:
                    Attendance.objects.create(
                        student=student,
                        subject=subject,
                        date=today,
                        status='Absent'  # Default status is Absent
                    )
                    print(f"Created attendance record for student {student.student_id}")
                except Exception as e:
                    print(f"Error creating attendance record: {e}")
                    
        return redirect('manage_attendance', session_id=session.id)
        
    except ValidationError as e:
        messages.error(request, f'Validation error: {str(e)}')
        return redirect('teacher_subjects')
    except Exception as e:
        messages.error(request, f'Error creating attendance session: {str(e)}')
        return redirect('teacher_subjects')

@login_required
def manage_attendance(request, session_id):
    """Manage an active attendance session"""
    if not hasattr(request.user, 'teacher'):
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
        
    session = get_object_or_404(AttendanceSession, id=session_id)
    subject = session.subject
    
    # Ensure the teacher owns this subject
    if subject.teacher != request.user.teacher:
        messages.error(request, 'Permission denied')
        return redirect('dashboard')
    
    # Get attendance records for this session
    attendance_records = Attendance.objects.filter(
        subject=subject,
        date=session.date
    ).select_related('student')
    
    if request.method == 'POST' and 'end_session' in request.POST:
        session.is_active = False
        session.end_time = timezone.now().time()
        session.save()
        messages.success(request, 'Attendance session ended')
        return redirect('teacher_subjects')
    
    return render(request, 'teacher/manage_attendance.html', {
        'session': session,
        'subject': subject,
        'attendance_records': attendance_records
    })

@login_required
def record_attendance(request):
    """Record student attendance via RFID scan (AJAX endpoint)"""
    if not request.method == 'POST':
        return JsonResponse({'status': 'error', 'message': 'Invalid request method'})
    
    rfid_card = request.POST.get('rfid_card')
    session_id = request.POST.get('session_id')
    
    if not rfid_card or not session_id:
        return JsonResponse({'status': 'error', 'message': 'Missing RFID or session ID'})
    
    try:
        # Get the active session
        session = AttendanceSession.objects.get(id=session_id, is_active=True)
        subject = session.subject
        
        # Get student by RFID
        student = Student.objects.get(rfid_card=rfid_card)
        
        # Check if current time is within class schedule
        current_time = timezone.localtime(timezone.now()).time()
        today = timezone.localtime(timezone.now()).date()
        current_datetime = datetime.datetime.combine(today, current_time)
        
        start_time = subject.schedule_start_time
        end_time = subject.schedule_end_time
        start_datetime = datetime.datetime.combine(today, start_time)
        end_datetime = datetime.datetime.combine(today, end_time)
        
        # Debug time comparison
        print(f"Recording attendance - Current time: {current_time}")
        print(f"Class start time: {start_time}")
        print(f"Class end time: {end_time}")
        
        # Check if it's too early for class
        if current_datetime < start_datetime:
            return JsonResponse({
                'status': 'error',
                'message': f'Cannot record attendance before class start time ({start_time.strftime("%I:%M %p")})'
            })
            
        # Check if student is enrolled in this subject
        if student not in subject.students.all():
            return JsonResponse({
                'status': 'error',
                'message': f'Student {student.full_name} is not enrolled in this subject'
            })
        
        # Check if attendance has already been recorded and is not "Absent"
        existing_attendance = Attendance.objects.filter(
            student=student,
            subject=subject,
            date=session.date
        ).first()
        
        if existing_attendance and existing_attendance.status != 'Absent':
            return JsonResponse({
                'status': 'warning',
                'message': f'Attendance for {student.full_name} has already been recorded at {existing_attendance.time.strftime("%H:%M:%S")}',
                'student_name': student.full_name,
                'student_id': student.student_id,
                'attendance_status': existing_attendance.status,
                'time': existing_attendance.time.strftime('%H:%M:%S')
            })
        
        # Update attendance record
        attendance, created = Attendance.objects.get_or_create(
            student=student,
            subject=subject,
            date=session.date,
            defaults={'status': 'Present', 'time': current_time}
        )
        
        if not created:
            # Record already exists, just update it
            attendance.status = 'Present'  # Override default status
            attendance.time = current_time
            attendance.save()
        
        # The save method will automatically update the status based on time difference
        
        return JsonResponse({
            'status': 'success',
            'student_name': student.full_name,
            'student_id': student.student_id,
            'attendance_status': attendance.status,
            'time': attendance.time.strftime('%H:%M:%S')
        })
        
    except AttendanceSession.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Invalid or inactive session'})
    except Student.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Student not found with this RFID'}) 