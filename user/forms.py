from django.forms import ModelForm
from django import forms
from .models import *

class UserForm(ModelForm):
    class Meta:
        model = User
        fields = '__all__'
        widgets = {
            'password_hash': forms.PasswordInput(),
        }

    def clean_password_hash(self):
        data = self.cleaned_data['password_hash']
        if len(data) < 8:
            raise forms.ValidationError('The password should as least 8 characters long.')

        return data

class UsermodForm(UserForm):

    class Meta:
        exclude = ('username', )

    def clean_password_hash(self):
        data = self.cleaned_data['password_hash']

        if not len(data) == 0:
            if len(data) < 8:
                raise forms.ValidationError('The password should as least 8 characters long.')

        return data
    """
    def clean_username(self):
        username = self.cleaned_data['username']
        return username
    """