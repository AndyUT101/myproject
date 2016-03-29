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
    shortcode = models.CharField(max_length=255, default="", unique=True)
    creator = models.ForeignKey(User, on_delete=models.CASCADE, default="")
    description = models.TextField(default="")

    STATUS_CHOICE = (
        ('O', 'Open'),
        ('C', 'Close'),
    )
    status = models.CharField(max_length=1, choices=STATUS_CHOICE, default="O")

    def __str__(self):
        return self.name

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
    announce_date = models.DateTimeField(default=timezone.now)

class Assignment_format(models.Model):
    datatype = models.CharField(max_length=255)
    dataext = models.CharField(max_length=255)

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
    upload_format = models.ForeignKey(Assignment_format, on_delete=models.CASCADE, default="")
    deadline_datetime = models.DateTimeField(default=timezone.now)
    fullmark = models.PositiveSmallIntegerField(default=100)
    classroom = models.ForeignKey(Classroom, on_delete=models.CASCADE, default="")
    create_date = models.DateTimeField(default=timezone.now)


class User_assignment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, default="")
    assign_date = models.DateTimeField(default=timezone.now)

    ROLE_CHOICES = (
        ('STU', 'Student'),
        ('TEA', 'Teacher'),
        ('ADM', 'Admin'),
        ('VIS', 'Visitor'),
    )
    role = models.CharField(max_length=3, choices = ROLE_CHOICES, default = 'STU')
    classroom = models.ForeignKey(Classroom, on_delete=models.CASCADE, default="")

    def __str__(self):
        return self.user.username + ": " + self.classroom.name + " [" + self.role + "]"


class Assignment_pool(models.Model):
    """
    user
    content (json form)
    """
    assignment = models.ForeignKey(Assignment, on_delete=models.CASCADE, default="")
    content = models.FileField(upload_to='uploads/%Y/%m/%d/', default="")
    mark = models.PositiveSmallIntegerField(default=100)
    user_assign = models.ForeignKey(User_assignment, on_delete=models.CASCADE, default="")

class Note(models.Model):
    """
    Title
    content
    publish_datetime
    status (publish, draft)
    """
    title = models.CharField(max_length=255, default="")
    content = models.TextField(default="")
    publish_datetime = models.DateTimeField(default=timezone.now)

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

class Material(models.Model):
    uploader = models.ForeignKey(User_assignment, on_delete=models.CASCADE, default="")
    create_date = models.DateTimeField(default=timezone.now)
    path = models.FileField(upload_to='uploads/%Y/%m/%d/', default="")

class Material_classroom(models.Model):
    material = models.ForeignKey(Material, on_delete=models.CASCADE, default="")
    classroom = models.ForeignKey(Classroom, on_delete=models.CASCADE, default="")
