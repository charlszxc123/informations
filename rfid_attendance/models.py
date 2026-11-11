from django.db import models
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError
from django.utils import timezone
import datetime

class Teacher(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    teacher_id = models.CharField(max_length=20, unique=True)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=15, blank=True)
    
    def __str__(self):
        return self.full_name

class Student(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    student_id = models.CharField(max_length=20, unique=True)
    full_name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    rfid_card = models.CharField(max_length=50, unique=True)
    
    def __str__(self):
        return self.full_name

class Subject(models.Model):
    code = models.CharField(max_length=20, unique=True)
    name = models.CharField(max_length=100)
    teacher = models.ForeignKey(Teacher, on_delete=models.CASCADE)
    students = models.ManyToManyField(Student, related_name='subjects')
    schedule_start_time = models.TimeField()
    schedule_end_time = models.TimeField()
    schedule_day = models.CharField(max_length=10, choices=[
        ('Monday', 'Monday'),
        ('Tuesday', 'Tuesday'),
        ('Wednesday', 'Wednesday'),
        ('Thursday', 'Thursday'),
        ('Friday', 'Friday'),
        ('Saturday', 'Saturday'),
        ('Sunday', 'Sunday'),
    ])
    
    def __str__(self):
        return f"{self.code} - {self.name}"
    
    def clean(self):
        if self.schedule_start_time and self.schedule_end_time:
            start_dt = datetime.datetime.combine(datetime.date.today(), self.schedule_start_time)
            end_dt = datetime.datetime.combine(datetime.date.today(), self.schedule_end_time)
            
            if end_dt <= start_dt:
                raise ValidationError("End time must be after start time.")
        
        super().clean()

class Attendance(models.Model):
    STATUS_CHOICES = [
        ('Present', 'Present'),
        ('Late', 'Late'),
        ('Absent', 'Absent'),
    ]
    
    student = models.ForeignKey(Student, on_delete=models.CASCADE)
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    date = models.DateField()
    time = models.TimeField(null=True, blank=True)
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='Absent')
    
    class Meta:
        unique_together = ['student', 'subject', 'date']
    
    def __str__(self):
        return f"{self.student} - {self.subject} - {self.date} - {self.status}"
    
    def save(self, *args, **kwargs):
        if not self.time and self.status != 'Absent':
            self.time = timezone.localtime().time()
            
        if self.status != 'Absent' and self.time:
            subject_start_time = self.subject.schedule_start_time
            subject_end_time = self.subject.schedule_end_time
            attendance_time = datetime.datetime.combine(datetime.date.today(), self.time)
            scheduled_start = datetime.datetime.combine(datetime.date.today(), subject_start_time)
            scheduled_end = datetime.datetime.combine(datetime.date.today(), subject_end_time)
            
            if attendance_time < scheduled_start:
                self.status = 'Absent'
            elif attendance_time > scheduled_end:
                self.status = 'Absent'
            else:
                time_diff = attendance_time - scheduled_start
                minutes_late = time_diff.total_seconds() / 60
                
                if minutes_late < 5:
                    self.status = 'Present'
                elif minutes_late < 60:
                    self.status = 'Late'
                else:
                    self.status = 'Absent'
                
        super().save(*args, **kwargs)

class AttendanceSession(models.Model):
    subject = models.ForeignKey(Subject, on_delete=models.CASCADE)
    date = models.DateField(default=timezone.now)
    start_time = models.TimeField()
    end_time = models.TimeField(null=True, blank=True)
    is_active = models.BooleanField(default=True)
    
    def __str__(self):
        return f"{self.subject} - {self.date}"
    
    def clean(self):
        if self.subject and self.start_time:
            current_day = timezone.localtime(timezone.now()).strftime('%A')
            if current_day != self.subject.schedule_day:
                raise ValidationError(f"Attendance can only be started on the scheduled day ({self.subject.schedule_day}).")
            
            session_start = datetime.datetime.combine(datetime.date.today(), self.start_time)
            subject_start = datetime.datetime.combine(datetime.date.today(), self.subject.schedule_start_time)
            subject_end = datetime.datetime.combine(datetime.date.today(), self.subject.schedule_end_time)
            
            if session_start < subject_start:
                raise ValidationError(f"Attendance cannot be started before the class start time ({self.subject.schedule_start_time.strftime('%I:%M %p')}).")
            
            if session_start > subject_end:
                raise ValidationError(f"Attendance cannot be started after the class end time ({self.subject.schedule_end_time.strftime('%I:%M %p')}).")
        
        super().clean()
    
    def save(self, *args, **kwargs):
        self.clean()
        super().save(*args, **kwargs)
