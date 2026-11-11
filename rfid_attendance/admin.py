from django.contrib import admin
from .models import Teacher, Student, Subject, Attendance, AttendanceSession

@admin.register(Teacher)
class TeacherAdmin(admin.ModelAdmin):
    list_display = ('teacher_id', 'full_name', 'email', 'phone')
    search_fields = ('teacher_id', 'full_name', 'email')
    ordering = ('full_name',)

@admin.register(Student)
class StudentAdmin(admin.ModelAdmin):
    list_display = ('student_id', 'full_name', 'email', 'rfid_card')
    search_fields = ('student_id', 'full_name', 'email', 'rfid_card')
    ordering = ('full_name',)

@admin.register(Subject)
class SubjectAdmin(admin.ModelAdmin):
    list_display = ('code', 'name', 'teacher', 'schedule_day', 'schedule_start_time', 'schedule_end_time')
    list_filter = ('schedule_day', 'teacher')
    search_fields = ('code', 'name', 'teacher__full_name')
    filter_horizontal = ('students',)

@admin.register(Attendance)
class AttendanceAdmin(admin.ModelAdmin):
    list_display = ('student', 'subject', 'date', 'time', 'status')
    list_filter = ('date', 'status', 'subject')
    search_fields = ('student__full_name', 'subject__name')
    date_hierarchy = 'date'

@admin.register(AttendanceSession)
class AttendanceSessionAdmin(admin.ModelAdmin):
    list_display = ('subject', 'date', 'start_time', 'end_time', 'is_active')
    list_filter = ('date', 'is_active', 'subject')
    search_fields = ('subject__name',)
    date_hierarchy = 'date'
