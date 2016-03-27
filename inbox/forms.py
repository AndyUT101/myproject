from django.forms import ModelForm
from .models import *

class ComposeForm(ModelForm):
    class Meta:
        model = Inbox
        fields = ["receiver", "content"]
