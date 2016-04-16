from .models import *
from user.models import User, Class_assignment, Class_code, Role

from datetime import date, time, timedelta

def current_rule(class_code):
    # return Rule object
    class_obj = Class_code.objects.get(class_name = class_code)
    current_applied_rule = Applied_rule.objects.filter(class_code = class_obj, start_date__lte = date.today(), end_date__gte = date.today())
    rule_index = {}
    for i in current_applied_rule:
        rule_index[i.rule.priority] = i

    applied_rule = rule_index[sorted(rule_index)[-1]]

    return applied_rule.rule

def list_attendance(class_code, date_val):
    att_list = []
    used_rule = current_rule(class_code)
    date_min = datetime.combine(date_val, time.min)
    date_max = datetime.combine(date_val, time.max)

    class_obj = Class_code.objects.get(class_name = class_code)
    user_list = [i.user for  i in class_obj.class_assignment_set.all() if i.user.role == Role.objects.get(name='student')]

    no_card_list = [i for i in user_list if not i.card_id == ""]
    user_list = no_card_list.symmetric_difference(user_list)

    abs_list = []
    for u in user_list:
        if Attandance.objects.filter(user=u, logged_datetime__range=(date_min, date_max)).count() == 0:
            abs_list.append(u)
    user_list = abs_list.symmetric_difference(user_list)

    on_time_list = []

    for u in user_list:
        arrive_time = Attandance.objects.filter(user= u, logged_datetime__range=(date_min, date_max)).order_by('logged_datetime')[0].logged_datetime
        if used_rule.start_time - arrive_time >= timedelta(0):
            on_time_list.append(u)

    user_list = on_time_list.symmetric_difference(user_list)
    late_list = user_list

    att_list = {}

    for u in no_card_list:
        class_number = Class_assignment.objects.get(user=u).class_number
        att_list[class_number] = (class_number, u, 'No card')

    for u in abs_list:
        class_number = Class_assignment.objects.get(user=u).class_number
        att_list[class_number] = (class_number, u, 'Absent')

    for u in on_time_list:
        class_number = Class_assignment.objects.get(user=u).class_number
        att_list[class_number] = (class_number, u, 'On Time')

    for u in late_list:
        class_number = Class_assignment.objects.get(user=u).class_number
        att_list[class_number] = (class_number, u, 'On Time')

        
    return att_list


