from user.models import Class_code
from datetime import datetime


def generate_attend_report(class_pk, attend_date):
    user_list = tuple(i.user for i in Class_code.objects.get(pk=class_pk).class_assignment_set.all())
    date = datetime.strptime(attend_date, '%Y-%m-%d')
