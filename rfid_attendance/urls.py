from django.urls import path
from . import views
from .views import *

urlpatterns = [
    path('', views.user_login, name='login'),
    path('logout/', views.user_logout, name='logout'),

    
    path('dashboard/', views.dashboard, name='dashboard'),
    
    
    path('teachers/', views.manage_teachers, name='manage_teachers'),
    path('teachers/add/', views.add_teacher, name='add_teacher'),
    path('teachers/edit/<int:teacher_id>/', views.edit_teacher, name='edit_teacher'),
    path('teachers/delete/<int:teacher_id>/', views.delete_teacher, name='delete_teacher'),
    
    path('students/', views.manage_students, name='manage_students'),
    path('students/add/', views.add_student, name='add_student'),
    path('students/edit/<int:student_id>/', views.edit_student, name='edit_student'),
    path('students/delete/<int:student_id>/', views.delete_student, name='delete_student'),
    
    path('student/subjects/', views.student_subjects, name='student_subject'),
    path('subjects/', views.manage_subjects, name='manage_subjects'),
    path('subjects/add/', views.add_subject, name='add_subject'),
    path('subjects/edit/<int:subject_id>/', views.edit_subject, name='edit_subject'),
    path('subjects/delete/<int:subject_id>/', views.delete_subject, name='delete_subject'),
    
    path('reset-password/', views.reset_password, name='reset_password'),
    path('change-password/', views.change_admin_password, name='change_admin_password'),
    
    path('teacher/subjects/', views.teacher_subjects, name='teacher_subjects'),
    path('teacher/subjects/<int:subject_id>/students/', views.subject_students, name='subject_students'),
    path('teacher/subjects/<int:subject_id>/start-attendance/', views.start_attendance, name='start_attendance'),
    path('teacher/attendance/manage/<int:session_id>/', views.manage_attendance, name='manage_attendance'),
    path('teacher/attendance/record/', views.record_attendance, name='record_attendance'),
    
    path('reports/attendance/', views.view_attendance_report, name='view_attendance_report'),
    path('reports/student/<int:student_id>/', views.student_attendance_history, name='student_attendance_history'),
    path('reports/my-attendance/', views.student_attendance_history, name='my_attendance_history'),
]