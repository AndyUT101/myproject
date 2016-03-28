from django import forms
from django.forms import ModelForm
from .models import *

from user.models import Class_code


class ApplyForm(ModelForm):
    CLASS_CODE_OPTIONS = tuple((i.pk, i.class_name) for i in Class_code.objects.all())
    class_assign = forms.MultipleChoiceField(widget=forms.CheckboxSelectMultiple, choices=CLASS_CODE_OPTIONS)
    
    class Meta:
        model = Applied_rule
        fields = ["rule", "class_assign"]


    def clean_class_assign(self):
        data = self.cleaned_data['class_assign']

        if len(data) == 0:
            raise forms.ValidationError('No receiver received!')
        return data