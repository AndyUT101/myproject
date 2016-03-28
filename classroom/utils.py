from django.core.exceptions import ObjectDoesNotExist

from datetime import datetime, timedelta

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

def allow_contentadd(role):
    if role == 'TEA' or role == 'ADM':
        return True
    return False

def handin_remaintime(assignment_obj):
    # return (int in days, Remain Text)
    current_time = datetime.now()
    deadline_time = assignment_obj.deadline_datetime

    day_left = (deadline_time - current_time).days
    remain_text = ''

    if day_left == 1 or day_left == -1:
        remain_text += " day "
    else:
        remain_text += ' days '
    if day_left > 0:
        remain_text = str(day_left) + remain_text + 'left'
    elif day_left < 0:
        remain_text = str(day_left) + remain_text + 'overdued'
    else:
        remain_text = 'not more than 1 day'

    return (day_left, remain_text)

def is_markvalid(mark, assignment_obj):
    full_mark = assignment_obj.fullmark
    if mark <= full_mark:
        return True
    return False

def get_contents(shortcode):
    captured_classroom = Classroom.objects.get(shortcode=shortcode)

    announce = Announce.objects.filter(classroom=captured_classroom)
    assignment = Assignment.objects.filter(classroom=captured_classroom)
    user_assign = User_assignment.objects.filter(classroom=captured_classroom)

    note = tuple(i.note for i in Classroom_note.objects.filter(classroom=captured_classroom))
    note = tuple(n for n in note if n.status == 'P')

    material = tuple(i.material for i in Material_classroom.objects.filter(classroom=captured_classroom))

    return {
        'classroom': captured_classroom,
        'announce': announce,
        'assignment': assignment,
        'user_assign': user_assign,
        'note': note,
        'material': material,
    }