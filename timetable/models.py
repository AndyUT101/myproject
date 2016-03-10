from django.db import models

from user.models import User

class Timetable(models.Model):
    event = models.ForeignKey(Activity_event, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

class Activity_event(models.Model):
	pass

class Calendar(models.Model):
	pass