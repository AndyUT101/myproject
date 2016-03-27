from django.forms import ModelForm

class FacilitiesForm(ModelForm):
    class Meta:
        model = Facilities
        fields = '__all__'