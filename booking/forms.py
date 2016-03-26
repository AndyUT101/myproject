from django.forms import ModelForm
from django import forms
from .models import *

class BookingForm(ModelForm):
    class Meta:
    	model = Booking
        fields = '__all__'