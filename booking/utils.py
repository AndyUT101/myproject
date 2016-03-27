from django.core.exceptions import ObjectDoesNotExist

from .models import Booking, Lesson
from facilities.models import Facilities
from datetime import datetime

def time_to_datetime(date, time):
    return datetime.combine(date, time)

def is_occupied(booking_obj):
    pass

def occupied_lesson_id(date, facility_id):
    # return occupied lesson id
    # datetime.strptime('2016-03-27', '%Y-%m-%d')
    if not isinstance(date, datetime):
        date = datetime.strptime(date, '%Y-%m-%d')

    try:
        selected_facility = Facilities.objects.get(pk = facility_id)

    except ObjectDoesNotExist:
        return []

    book_item = Booking.objects.filter(book_date = date, facility = selected_facility)
    lesson_list = Lesson.objects.all()

    # return [(start_key, end_key)]
    book_item_key = [(i.start_lesson.pk, i.end_lesson.pk) for i in book_item]
    lesson_dict = {i.pk:(i.start_time, i.end_time) for i in Lesson.objects.all()}
    lesson_dict = {i.pk:(time_to_datetime(date, i.end_time)+(time_to_datetime(date, i.end_time)-time_to_datetime(date, i.start_time))) for i in Lesson.objects.all()}

    lesson_id_list = []
    for b in book_item_key:
    	if b[0] == b[1]:
    		lesson_id_list.append(b[0])
    		continue


    pass