from django.forms import ModelForm
from django import forms
from .models import *

class UserForm(ModelForm):
    class Meta:
        model = User
        fields = '__all__'
        widgets = {
            'password': forms.PasswordInput(),

        }
        exclude = ('last_logged', )
        help_texts = {
            'password': 'The password should at least 8 characters.'
        }

    def clean_password(self):
        data = self.cleaned_data['password']
        if len(data) < 8:
            raise forms.ValidationError('The password should as least 8 characters long.')

        return data

class UsermodForm(UserForm):

    class Meta:
        model = User
        fields = '__all__'
        widgets = {
            'password': forms.PasswordInput(),
        }
        exclude = ('username', 'last_logged', )

class UsersimpleForm(UserForm):

    class Meta:
        model = User
        fields = ['firstname', 'lastname', 'password', 'phone', 'mobile', 'email']
        widgets = {
            'password': forms.PasswordInput(),
        }


class ClasscodeForm(ModelForm):
    class Meta:
        model = Class_assignment
        fields = ['class_number']
        help_texts = {
            'class_number': 'Assign class number for the user'
        }