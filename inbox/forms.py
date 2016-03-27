from django import forms
from django.forms import ModelForm
from .models import *


class ComposeForm(ModelForm):
    receiver = forms.CharField(max_length=255)
    class Meta:
        model = Inbox_content
        fields = ["receiver", "content"]

"""
class ComposeForm(forms.Form):
    receiver = forms.CharField(max_length=255)
    title = forms.CharField(max_length=255)
    content = forms.CharField(required=False, widget=forms.Textarea)

"""