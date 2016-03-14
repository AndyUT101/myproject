from django.db import models

from user.models import User

class User_assignment(models.Model):
    pass
    """
    user_id
    assigment_id
    assign_date (datetime)
    role (stu, teacher)
    """

class Classroom(models.Model):
    pass
    """
    name
    user_whoopen
    description
    status (open, close)
    """

class Announce(models.Model):
    pass
    """
    classroom_id
    announce_title
    announce_content
    announce_type (sub-table?!)
    """

class Assignment_pool(models.Model):
    pass
    """
    user
    content (json form)
    """

class Assignment(models.Model):
    pass
    """
    Assignment_title
    Assignment_instruction
    Assignment_method (upload, text)
    Assignment_deadline
    Assignment_fullmark
    """

class Exercise(models.Model):
    pass
    """
    title
    instruction
    """

class Note(models.Model):
    pass
    """
    Title
    content
    publish_datetime
    status (publish, draft)
    """


class Classroom_note(models.Model):
    """
    A model for matching classroom and note, prevent many to many
    """
    pass
    """
    classroom
    note
    """

class Material_type(models.Model):
    pass
    """
    type_name (eg. photo, document, zip)
    type_description
    """

class Material_ext(models.Model):
    pass
    """
    ext_name
    material_type (foreign)
    """

class Material(models.Model):
    pass
    """
    uploader
    datetime
    classroom
    material_path (unique)
    """