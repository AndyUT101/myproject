from django.db import models

from user.models import User

class Activity_event(models.Model):
    location = models.CharField(max_length=255, default="")
    description = models.TextField(default="")
    activity_name = models.ForeignKey(Event_terms, on_delete=models.CASCADE)

class Calendar(models.Model):
    name = models.CharField(max_length=255, default="")
    description = models.TextField(default="")
    
class Timetable(models.Model):
    event = models.ForeignKey(Activity_event, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    calender = model.ForeignKey(Calender, on_delete=models.CASCADE)

class Event_terms(models.Model):
    event_term = models.CharField(max_length=255, default="")

