from django.db import models
from django.utils import timezone

from attendance.models import Attandance
from user.models import User


class Report_type(models.Model):
    title = models.CharField(max_length=255, default="", unique=True)
    description = models.TextField(default="")
    layout_json = models.TextField(default="")

class Report(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, default="")
    generate_datetime = models.DateTimeField(default=timezone.now)
    report_type = models.ForeignKey(Report_type, on_delete=models.CASCADE, default="")
