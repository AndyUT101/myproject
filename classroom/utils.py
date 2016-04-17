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

def user_assign_assignment(shortcode, username):
    try:
        captured_user = User.objects.get(username=username)
        captured_classroom = Classroom.objects.get(shortcode=shortcode)

        captured_assignment = User_assignment.objects.get(user=captured_user, classroom=captured_classroom)

    except ObjectDoesNotExist:
        return False

    return captured_assignment

def role_tidyprint(role_short):
    role = {'STU': 'Student', 'TEA': 'Teacher', 'ADM': 'Admin', 'VIS': 'Visitor'}
    return role[role_short]

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
    user_assign_stu = User_assignment.objects.filter(classroom=captured_classroom, role='STU')
    user_assign_tea = User_assignment.objects.filter(classroom=captured_classroom, role='TEA')

    note = [i.note for i in Classroom_note.objects.filter(classroom=captured_classroom)]
    note = [n for n in note if n.status == 'P']

    material = [i.material for i in Material_classroom.objects.filter(classroom=captured_classroom)]

    return {
        'classroom': captured_classroom,
        'announce': announce,
        'assignment': assignment,
        'user_assign_stu': user_assign_stu,
        'user_assign_tea': user_assign_tea,
        'note': note,
        'material': material,
    }

def get_contentscount(contents_dict): 
    contents_dict.pop('classroom', None)
    for key in contents_dict:
        contents_dict[key] = len(contents_dict[key])

    return contents_dict

def right_nav(shortcode):
    return (
                {'title': 'Announce','url': 'classroom:announce',
                'url_para': shortcode,},

                {'title': 'Assignment', 'url': 'classroom:assignment_list',
                'url_para': shortcode, },

                {'title': 'Note', 'url': 'classroom:note',
                'url_para': shortcode, },

                {'title': 'Material', 'url': 'classroom:material',
                'url_para': shortcode, },
            )

def classroom_has_assignment(shortcode, assignment_id):
    captured_assignment = Assignment.objects.get(pk = assignment_id)
    captured_classroom = Classroom.objects.get(shortcode = shortcode)

    if captured_assignment.classroom == captured_classroom:
        return True
    return False