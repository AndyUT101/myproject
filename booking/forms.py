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
        clean_startlesson = cleaned_data.get('start_lesson').pk
        clean_endlesson = cleaned_data.get('end_lesson').pk

        if clean_startlesson and clean_endlesson:
            occupied_id = occupied_lesson_id(clean_bookdate, clean_facility)
            if clean_startlesson in occupied_id or clean_endlesson in occupied_id:
                self.add_error('start_lesson', "Select timeslot is already booked by other!")
                self.add_error('end_lesson', "Please check and resubmit again.")
