from django.core.exceptions import ObjectDoesNotExist

from .models import Facilities, Room

def is_available(facility):
    return facility.room.available