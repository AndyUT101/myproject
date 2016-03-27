from django.forms import ModelForm
from django import forms
from .utils import occupied_lesson_id
from .models import *

from datetime import datetime, time, timedelta

class BookingForm(ModelForm):
    class Meta:
        model = Booking
        fields = '__all__'
        exclude = ('user', )

    def clean(self):
        cleaned_data = super(BookingForm, self).clean()
        clean_bookdate = cleaned_data.get('book_date')
        clean_facility = cleaned_data.get('facility')
        clean_startlesson = cleaned_data.get('start_lesson')
        clean_endlesson = cleaned_data.get('end_lesson')

        if clean_bookdate and clean_facility and clean_startlesson and clean_endlesson:
            occupied_id = occupied_lesson_id(clean_bookdate, clean_facility)
            if clean_startlesson.pk in occupied_id or clean_endlesson.pk in occupied_id:
                raise forms.ValidationError(
                    "Select timeslot is already booked by other! Please check and resubmit again."
                )

