from django.db import models

from attendance.models import Attandance
from user.models import User

class Attendant(models.Model):
    pass

class Result(models.Model):
    pass


class Report_type(models.Model):
    report_title = models.CharField(max_length=255, default="", unique=True)
    report_description = models.TextField(default="")