from django.forms import ModelForm
from django import forms
from .utils import occupied_lesson

from datetime import datetime, time, timedelta

class BookingForm(ModelForm):
    class Meta:
        model = Booking
        fields = '__all__'
        exclude = ('user', )

    def clean(self):
        cleaned_data = super(Booking, self).clean()
        clean_startlesson = cleaned_data.get('start_lesson')
        clean_endlesson = cleaned_data.get('end_lesson')

        if clean_startlesson and clean_endlesson:
            occupied_id = occupied_lesson()
            if clean_startlesson in occupied_id or clean_endlesson in occupied_lesson:
                raise forms.ValidationError(
                    "Select timeslot is already booked by other!",
                    "Please check and resubmit again."
                )
