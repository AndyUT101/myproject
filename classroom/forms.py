from django.forms import ModelForm
from django import forms
from .models import *

class ClassroomForm(ModelForm):
    class Meta:
        model = Classroom
        fields = '__all__'