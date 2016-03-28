from datetime import date, time

from django.db import models
from django.utils import timezone

from user.models import User, Class_code

class Attandance(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    logged_datetime = models.DateTimeField(default=timezone.now)

class Rule(models.Model):
    name = models.CharField(max_length=255, default="")
    recursive = models.BooleanField(default=False)
    priority = models.PositiveIntegerField(default=0)
    start_time = models.TimeField(default=time(8,0,0))
    end_time = models.TimeField(default=time(17,0,0))

    def __str__(self):
        return self.name

class Applied_rule(models.Model):
    rule = models.ForeignKey(Rule, on_delete=models.CASCADE)
    class_code = models.ForeignKey(Class_code, on_delete=models.CASCADE, default="")
    applied_datetime = models.DateTimeField(default=timezone.now)
    exclude_weekend = models.BooleanField(default=True)
