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

    def clean(self):
    	cleaned_data = super(UserForm, self).clean()
    	cc_password = cleaned_data.get('password_hash')

    	if cc_password:
    		if len(cc_password):
    			raise forms.ValidationError('The password should as least 8 characters long.')
