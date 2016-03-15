from django.db import models

from attendance.models import Attandance
from user.models import User

class Report_type(models.Model):
    title = models.CharField(max_length=255, default="", unique=True)
    description = models.TextField(default="")
    layout_json = models.TextField(default="")