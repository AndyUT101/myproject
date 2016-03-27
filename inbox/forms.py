from django import forms
from django.forms import ModelForm
from .models import *
from .utils import *


class ComposeForm(ModelForm):
    receiver = forms.CharField(max_length=255)
    class Meta:
        model = Inbox_content
        fields = ["receiver", "title", "content"]

    def clean_receiver(self):
        data = self.cleaned_data['receiver']
        user_verify = user_valid(data)
        if len(data) == 0:
            raise forms.ValidationError('No receiver received!')
        elif user_verify[0] == False:
            raise forms.ValidationError('Cannot send message to '+', '.join(user_verify[1]))
            
        return data