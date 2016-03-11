import datetime

from django.db import models
from django.utils import timezone

class User(models.Model):
    username = models.CharField(max_length=255, default="")

    firstname = models.CharField(max_length=255, default="")
    lastname = models.CharField(max_length=255, default="")
    password_hash = models.CharField(max_length=64, default="")
    card_id = models.CharField(max_length=20, default="")
    strn_code = models.CharField(max_length=12, default="")
    sams_code = models.CharField(max_length=12, default="")
    jupas_app_code = models.CharField(max_length=32, default="")
    barcode = models.CharField(max_length=32, default="")
    birth_date = models.DateField(auto_now=False, null=True)
    hkid_card = models.CharField(max_length=12, default="")
    address = models.TextField(default="")
    phone = models.CharField(max_length=24, default="")
    mobile = models.CharField(max_length=24, default="")
    email = models.EmailField(max_length=254, default="")
    national = models.CharField(max_length=24, default="")
    location_of_birth = models.CharField(max_length=24, default="")
    intake_date = models.CharField(max_length=24, default="")

    def __str__(self):
    	return self.username

class Role(models.Model):
    ROLE_USER_CHOICES = (
        ('STU', 'Student'),
        ('TEA', 'Teacher'),
        ('STA', 'Staff'),
        ('ALU', 'Alumni'),
        ('ADM', 'Admin'),
    )

    role_user = models.CharField(max_length = 3, choices = ROLE_USER_CHOICES, default = 'STU')
    
    # assign foreigh key linking to user
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        return self.role_user

class Permission_meta(models.Model):
    permission_key = models.CharField(max_length=255, default="")
    permission_description = models.CharField(max_length=255, default="")

class Permission(models.Model):
    permission_key = models.ForeignKey(Permission_meta, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)

class Session(models.Model):
    timeout_delta = datetime.timedelta(hours=5)

    session_token = models.CharField(max_length=32, default="")

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    timeout = models.DateTimeField(default=datetime.datetime.now()+timeout_delta)

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

"""
class_code
class_assignment

"""

class Class_code(models.Model):
    class_name = models.CharField(max_length=2, default="")
    class_description = models.CharField(max_length=255, default="")

    def __str__(self):
        return self.class_name

class Class_assignment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    class_code = models.ForeignKey(Class_code, on_delete=models.CASCADE)
