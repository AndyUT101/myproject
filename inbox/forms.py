from django import forms
from django.forms import ModelForm
from .models import *

"""
class ComposeForm(ModelForm):
    class Meta:
        model = Inbox
        fields = ["receiver", "content"]

"""

class ComposeForm(forms.Form):
    sender = forms.CharField(max_length=255)
    title = forms.CharField(max_length=255)
    content = forms.TextField(required=False)

