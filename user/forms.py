from django.forms import ModelForm
from django import forms
from .models import *

class UserForm(ModelForm):
    class Meta:
        model = User
        fields = ["username", "firstname", "lastname", "password_hash", "sex_code", "card_id", "strn_code", "sams_code", "jupas_app_code", "barcode", "birth_date", "hkid_card", "address", "phone", "mobile", "email", "national", "location_of_birth", "intake_date"]
        widgets = {
            'password_hash': forms.PasswordInput(),
        }
