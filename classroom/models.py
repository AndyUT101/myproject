from django.db import models
from django.utils import timezone

from user.models import User

class Classroom(models.Model):
    """
    name
    user_whoopen
    description
    status (open, close)
    """
    name = models.CharField(max_length=255, default="")
    creator = models.ForeignKey(User, on_delete=models.CASCADE, default="")
    description = models.TextField(default="")

    STATUS_CHOICE = (
        ('O', 'Open'),
        ('C', 'Close'),
    )
    status = models.CharField(max_length=1, choices=STATUS_CHOICE, default="O")


class Announce(models.Model):
    """
    classroom_id
    title
    content
    announce_date
    ## type (sub-table?!)
    """
    classroom = models.ForeignKey(Classroom, on_delete=models.CASCADE, default="")
    title = models.CharField(max_length=255, default="")
    content = models.TextField(default="")
    announce_date = models.DateTimeField(default=timezone.now, blank=True)

class Assignment(models.Model):
    """
    title
    instruction
    method (upload, text)
    deadline
    fullmark
    """
    title = models.CharField(max_length=255, default="")
    instruction = models.TextField(default="")

    METHOD_CHOICE = (
        ('U', 'Upload'),
        ('T', 'Text'),
    )
    handin_method = models.CharField(max_length=1, choices=METHOD_CHOICE, default="D")
    deadline_datetime = models.DateTimeField(default=timezone.now, blank=True)
    fullmark = models.PositiveSmallIntegerField(default=100)

class User_assignment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, default="")
    assigment = models.ForeignKey(Assignment, on_delete=models.CASCADE, default="")
    assign_date = models.DateTimeField(default=timezone.now, blank=True)

    ROLE_CHOICES = (
        ('STU', 'Student'),
        ('TEA', 'Teacher'),
        ('ADM', 'Admin'),
        ('VIS', 'Visitor'),
    )
    role = models.CharField(max_length=3, choices = ROLE_CHOICES, default = 'STU')


class Assignment_pool(models.Model):
    """
    user
    content (json form)
    """
    user_assignment = models.ForeignKey(User_assignment, on_delete=models.CASCADE, default="")
    content_json = models.TextField(default="")
    mark = models.PositiveSmallIntegerField(default=100)

class Note(models.Model):
    """
    Title
    content
    publish_datetime
    status (publish, draft)
    """
    title = models.CharField(max_length=255, default="")
    content = models.TextField(default="")
    publish_datetime = models.DateTimeField(default=timezone.now, blank=True)

    STATUS_CHOICE = (
        ('P', 'Published'),
        ('D', 'Drafted'),
        ('T', 'Trashed'),
    )
    status = models.CharField(max_length=1, choices=STATUS_CHOICE, default="D")


class Classroom_note(models.Model):
    """
    A model for matching classroom and note, prevent many to many
    """
    classroom = models.ForeignKey(Classroom, on_delete=models.CASCADE, default="")
    note = models.ForeignKey(Note, on_delete=models.CASCADE, default="")

class Material_type(models.Model):
    """
    type_name (eg. photo, document, zip)
    type_description
    """
    type_name = models.CharField(max_length=255, default="")
    type_description = models.TextField(default="")

class Material_ext(models.Model):
    ext_name = models.CharField(max_length=255, default="", unique=True)
    material_type = models.ForeignKey(Material_type, on_delete=models.CASCADE, default="")

class Material(models.Model):
    uploader = models.ForeignKey(User, on_delete=models.CASCADE, default="")
    create_date = models.DateTimeField(default=timezone.now, blank=True)
    classroom = models.ForeignKey(Classroom, on_delete=models.CASCADE, default="")
    path = models.FileField(upload_to='uploads/%Y/%m/%d/', default="")
    material_type = models.ForeignKey(Material_type, on_delete=models.CASCADE, default="")
