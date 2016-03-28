from django.core.exceptions import ObjectDoesNotExist

from .models import *
from user.models import User

def is_memberinfo(shortcode, username):

    # return (True/False, user_role)

    try:
        captured_user = User.objects.get(username=username)
        captured_classroom = Classroom.objects.get(shortcode=shortcode)

        captured_assignment = User_assignment.objects.get(user=captured_user, classroom=captured_classroom)

    except ObjectDoesNotExist:
        return (False, None)

    return (True, captured_assignment.role)


def 