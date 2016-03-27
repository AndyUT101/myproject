from django.forms import ModelForm

from .models import *

class FacilitiesForm(ModelForm):
    class Meta:
        model = Facilities
        fields = '__all__'

class RoomForm(ModelForm):
    class Meta:
        model = Room
        fields = '__all__'