from .auth_views import user_login, user_logout
from .dashboard_views import dashboard
from .admin_views import (
    manage_teachers, add_teacher, edit_teacher, delete_teacher,
    manage_students, add_student, edit_student, delete_student,
    manage_subjects, add_subject, edit_subject, delete_subject,
    reset_password, change_admin_password, 
)
from .teacher_views import (
    teacher_subjects, subject_students, start_attendance,
    manage_attendance, record_attendance, student_subjects
)
from .report_views import view_attendance_report, student_attendance_history 