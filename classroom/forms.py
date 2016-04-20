from django.forms import ModelForm
from django import forms
from .models import *

class ClassroomForm(ModelForm):
    class Meta:
        model = Classroom
        fields = '__all__'
        exclude = ['creator']

class AnnounceForm(ModelForm):
    class Meta:
        model = Announce
        fields = '__all__'
        exclude = ['classroom', 'announce_date']

class AssignmentForm(ModelForm):
    class Meta:
        model = Assignment
        fields = '__all__'
        exclude = ['classroom', 'create_date']

class User_assignmentForm(ModelForm):
    class Meta:
        model = User_assignment
        fields = '__all__'

class Assignment_submitForm(ModelForm):
    class Meta:
        model = Assignment_pool
        fields = '__all__'

        exclude = ['assignment', 'mark', 'user_assign']

class Assignment_markForm(ModelForm):
    class Meta:
        model = Assignment_pool
        fields = ('mark',)

class NoteForm(ModelForm):
    class Meta:
        model = Note
        fields = '__all__'

class Classroom_noteForm(ModelForm):
    class Meta:
        model = Classroom_note
        fields = '__all__'

class MaterialForm(ModelForm):
    class Meta:
        model = Material
        fields = '__all__'

class Material_classroomForm(ModelForm):
    class Meta:
        model = Material_classroom
        fields = '__all__'

class FormatForm(ModelForm):
    class Meta:
        model = Assignment_format
        fields = '__all__'
