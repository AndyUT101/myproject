import datetime

from django.db import models

from user.models import User

class Time_meta(models.Model):
    time_obj = models.DateTimeField(default=datetime.datetime.now(), unique=True)

class Event_terms(models.Model):
    event_term = models.CharField(max_length=255, default="")

class Activity_event(models.Model):
    location = models.CharField(max_length=255, default="")
    description = models.TextField(default="")
    activity_name = models.ForeignKey(Event_terms, on_delete=models.CASCADE)
    start_date = models.ForeignKey(Time_meta, on_delete=models.CASCADE, related_name='start_time_profile', default="")
    end_date = models.ForeignKey(Time_meta, on_delete=models.CASCADE, related_name='end_time_profile', default="")

class Calendar(models.Model):
    name = models.CharField(max_length=255, default="")
    description = models.TextField(default="")

class Timetable(models.Model):
    event = models.ForeignKey(Activity_event, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    calender = models.ForeignKey(Calendar, on_delete=models.CASCADE)



