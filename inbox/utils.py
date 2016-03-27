from django.db.models import Q
from functools import reduce
from operator import __or__ as OR

from user.models import User

def split_receiver(data):
    data = data.replace(' ', '')
    data = data.split(',')

    return list(filter(None, set(data)))

def user_valid(user_listdata):
    if not user_listdata:
        return (False, [])
    # replace space
    user_list = split_receiver(user_listdata)
    django_or = [Q(username = i) for i in user_list]
    user_match_list = [i.username for i in User.objects.filter(reduce(OR, django_or))]
    if len(user_match_list) == len(user_list):
        return (True, [])
    else:
        return (False, list(set(user_list).symmetric_difference(user_match_list)))