from django.forms import ModelForm
from django import forms

from user.models import Class_code

class Report_attend(forms.Form):
	CLASS_CHOICE = tuple((i.class_name, i.class_name) for i in Class_code.objects.all())
    class_code = forms.ChoiceField(choices=CLASS_CHOICE)