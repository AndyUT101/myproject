from datetime import datetime, timedelta, date

from django.db import models
from django.utils import timezone

class Role(models.Model):
    name = models.CharField(max_length=24, default="student")
    level = models.PositiveSmallIntegerField(default = 0)
    
    def __str__(self):
        return self.name


class User(models.Model):
    SEX_CHOICES = (
        ('M', 'Male'),
        ('F', 'Female'),
    )

    username = models.CharField(max_length=255, default="", unique=True)

    firstname = models.CharField(max_length=255, default="")
    lastname = models.CharField(max_length=255, default="")
    password = models.CharField(max_length=96, default="")
    sex_code = models.CharField(max_length = 1, choices = SEX_CHOICES, default = '', blank=True)
    card_id = models.CharField(max_length=20, default="", blank=True)
    strn_code = models.CharField(max_length=12, default="", blank=True)
    sams_code = models.CharField(max_length=12, default="", blank=True)
    jupas_app_code = models.CharField(max_length=32, default="", blank=True)
    barcode = models.CharField(max_length=32, default=None, blank=True, unique=True)
    birth_date = models.DateField(auto_now=False, null=True, blank=True)
    hkid_card = models.CharField(max_length=12, default=None, blank=True, unique=True)
    address = models.TextField(default="", blank=True)
    phone = models.CharField(max_length=24, default="", blank=True)
    mobile = models.CharField(max_length=24, default="", blank=True)
    email = models.EmailField(max_length=254, default="", blank=True)
    national = models.CharField(max_length=24, default="", blank=True)
    location_of_birth = models.CharField(max_length=24, default="", blank=True)
    intake_date = models.DateField(default=date.today, blank=True)
    last_logged = models.DateTimeField(null=True, blank=True)

    role = models.ForeignKey(Role, on_delete=models.CASCADE, default=1)

    def __str__(self):
        return self.username

class Permission_meta(models.Model):
    key = models.CharField(max_length=255, default="")
    description = models.CharField(max_length=255, default="")
    level = models.PositiveSmallIntegerField(default = 5)

    def __str__(self):
        return self.key

class Permission(models.Model):
    permission = models.ForeignKey(Permission_meta, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.user.username + ": " + self.permission.key

class Parent_contact(models.Model):
    PARENT_TYPE_CHOICE = (
        ('F', 'Father'),
        ('M', 'Mother'),
        ('G', 'Guardian'),
        ('O', 'Other'),
    )

    parent_name = models.CharField(max_length=255, default="")
    parent_type = models.CharField(max_length = 1, choices = PARENT_TYPE_CHOICE, default="")
    parent_phone = models.CharField(max_length=24, default="")

    # assign foreigh key linking to user
    user = models.ForeignKey(User, on_delete=models.CASCADE)

class Class_code(models.Model):
    class_name = models.CharField(max_length=2, default="")
    class_description = models.CharField(max_length=255, default="")

    def __str__(self):
        return self.class_name

class Class_assignment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    class_code = models.ForeignKey(Class_code, on_delete=models.CASCADE)
    class_number = models.IntegerField(default=0)
