from django import forms
from django.forms import ModelForm
from .models import *

from user.models import Class_code


class ApplyForm(ModelForm):
    CLASS_CODE_OPTIONS = tuple((i.pk, i.class_name) for i in Class_code.objects.all())
    class_assign = forms.MultipleChoiceField(widget=forms.CheckboxSelectMultiple, choices=CLASS_CODE_OPTIONS)
    
    class Meta:
        model = Applied_rule
        fields = ["rule", "class_assign", "exclude_weekend"]
