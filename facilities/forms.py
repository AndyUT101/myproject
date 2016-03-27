from django.forms import ModelForm

from .models import *

class FacilitiesForm(ModelForm):
    class Meta:
        model = Facilities
        fields = '__all__'