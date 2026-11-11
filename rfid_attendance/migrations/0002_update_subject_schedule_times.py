# Generated manually

from django.db import migrations, models

class Migration(migrations.Migration):

    dependencies = [
        ('rfid_attendance', '0001_initial'),
    ]

    operations = [
        # First add the new fields
        migrations.AddField(
            model_name='subject',
            name='schedule_start_time',
            field=models.TimeField(default='08:00:00'),
            preserve_default=False,
        ),
        migrations.AddField(
            model_name='subject',
            name='schedule_end_time',
            field=models.TimeField(default='09:30:00'),
            preserve_default=False,
        ),
        # Then copy data from schedule_time to schedule_start_time
        migrations.RunSQL(
            """
            UPDATE rfid_attendance_subject 
            SET schedule_start_time = schedule_time,
                schedule_end_time = ADDTIME(schedule_time, '01:30:00')
            """
        ),
        # Finally remove the old field
        migrations.RemoveField(
            model_name='subject',
            name='schedule_time',
        ),
    ] 