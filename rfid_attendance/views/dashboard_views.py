from django.shortcuts import *
from django.contrib.auth.decorators import login_required
from django.utils import timezone
import datetime
from django.contrib import messages
from ..models import *
from ..forms import *
from django.http import JsonResponse

# @login_required
# def dashboard(request):
#     user = request.user
#     context = {}

#     if user.is_superuser:
#         context['user_type'] = 'admin'
#         context['teachers_count'] = Teacher.objects.count()
#         context['students_count'] = Student.objects.count()
#         context['subjects_count'] = Subject.objects.count()
#         context['students'] = Student.objects.all()  # ✅ for the table at the bottom

#     elif hasattr(user, 'teacher'):
#         teacher = user.teacher
#         context['user_type'] = 'teacher'
#         context['teacher'] = teacher
#         context['subjects'] = Subject.objects.filter(teacher=teacher)

#     elif hasattr(user, 'student'):
#         student = user.student
#         context['user_type'] = 'student'
#         context['student'] = student
#         context['subjects'] = student.subjects.all()

#         today = timezone.now().date()
#         context['recent_attendance'] = Attendance.objects.filter(
#             student=student,
#             date__gte=today - datetime.timedelta(days=7)
#         ).order_by('-date')
        

#     return render(request, 'dashboard.html', context)

# @login_required
# def latest_attendance_record(request):
#     rfid = request.GET.get('rfid')

#     if not rfid:
#         return JsonResponse({'found': False})

#     try:
#         student = Student.objects.get(rfid_card=rfid)
#     except Student.DoesNotExist:
#         return JsonResponse({'found': False})

#     # Get the latest attendance for the student
#     latest = Attendance.objects.select_related('student', 'subject').filter(student=student).order_by('-date', '-time').first()

#     if not latest:
#         return JsonResponse({'found': False})

#     return JsonResponse({
#         'found': True,
#         'student': latest.student.full_name,
#         'student_id': latest.student.student_id,
#         'subject': latest.subject.name,
#         'status': latest.status,
#         'time': latest.time.strftime('%I:%M %p') if latest.time else 'N/A',
#         'date': latest.date.strftime('%B %d, %Y'),
#     })

@login_required
def dashboard(request):
    user = request.user
    context = {}

    if 'rfid' in request.GET:  # Checking if the request is for the latest attendance
        rfid = request.GET.get('rfid')

        if not rfid:
            return JsonResponse({'found': False})

        try:
            student = Student.objects.get(rfid_card=rfid)
        except Student.DoesNotExist:
            return JsonResponse({'found': False})

        # Get the latest attendance for the student
        latest = Attendance.objects.select_related('student', 'subject').filter(student=student).order_by('-date', '-time').first()

        if not latest:
            return JsonResponse({'found': False})

        return JsonResponse({
            'found': True,
            'student': latest.student.full_name,
            'student_id': latest.student.student_id,
            'subject': latest.subject.name,
            'status': latest.status,
            'time': latest.time.strftime('%I:%M %p') if latest.time else 'N/A',
            'date': latest.date.strftime('%B %d, %Y'),
        })

    # Default behavior for dashboard
    if user.is_superuser:
        context['user_type'] = 'admin'
        context['teachers_count'] = Teacher.objects.count()
        context['students_count'] = Student.objects.count()
        context['subjects_count'] = Subject.objects.count()
        context['students'] = Student.objects.all()  # ✅ for the table at the bottom

    elif hasattr(user, 'teacher'):
        teacher = user.teacher
        context['user_type'] = 'teacher'
        context['teacher'] = teacher
        context['subjects'] = Subject.objects.filter(teacher=teacher)

    elif hasattr(user, 'student'):
        student = user.student
        context['user_type'] = 'student'
        context['student'] = student
        context['subjects'] = student.subjects.all()

        today = timezone.now().date()
        context['recent_attendance'] = Attendance.objects.filter(
            student=student,
            date__gte=today - datetime.timedelta(days=7)
        ).order_by('-date')

    return render(request, 'dashboard.html', context)
