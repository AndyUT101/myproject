from django.shortcuts import render, render_to_response
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from django import forms
from django.template import RequestContext
from user.models import User, Class_assignment, Class_code, Role

from datetime import date, time, timedelta, datetime

import pyexcel.ext.xlsx
import django_excel as excel

from .forms import *
from .utils import *
from .toexcel import *

from attendance.utils import *
from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav

# Django-excel
# http://django-excel.readthedocs.org/en/latest/


# Create your views here.
# helper function
def list_report(request):
    page_title = 'Report management'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not review_permission(User.objects.get(username = request.session['user']), 'allow:user_add'):
        return HttpResponseRedirect(reverse('index_home'))

    return render(request, 'home.html', {
        'page_header': page_title,
        'template': 'list', # operation, list,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'content': {
            'list': {
                'checkbox': True,
                'name': 'overview',
                'body': (
                    ({'name': 'Attendant Report',
                        'url': 'report:attend_form'}),

                    ({'name': 'Class student list',
                        'url': 'report:class_report',
                        'para': '2B'}),

                    ({'name': 'All student list',
                        'url': 'report:all_student'}),
                ),
                'foot': (),
            },
        },
    })

def generate_report(request):
    user_dataset = User.objects.all()
    column_name = ['pk', 'username', 'firstname', 'lastname', 'role.name']
    return excel.make_response_from_query_sets(user_dataset, column_name, 'xlsx', file_name="custom")

def generate_class_report(request, class_name):
    user_class_dataset = Class_code.objects.get(class_name = class_name)
    user_list = [i.user for  i in user_class_dataset.class_assignment_set.all() if i.user.role == Role.objects.get(name='student')]
    column_name = ['pk', 'username', 'firstname', 'lastname', 'role.name']
    return excel.make_response_from_query_sets(user_dataset, column_name, 'xlsx', file_name=class_name+'_stu')

def attend_form(request):
    form_obj = Report_attend()

    if request.method == 'POST':
        form_obj = Report_attend(request.POST)
        if form_obj.is_valid():
            class_code = request.POST.get('class_code', '')
            attend_date = request.POST.get('attend_date', '')
            return HttpResponseRedirect(reverse('report:attend_export', kwargs={'attend_date': attend_date, 'class_code': class_code}))



    return render(request, 'home.html', {
        'page_title': 'Generate attendant report',
        'page_header': 'Generate attendant report',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'form',
        'content': {
            'form': form_obj.as_ul(),
            'submit_url': 'report:attend_form',
        },
    })

def attend_export(request, attend_date, class_code):
    attendance_data = list_attendance(class_code, date(2016, 4, 16))
    return export_excel(attendance_xls(attendance_data, class_code, attend_date))

def class_student_export(request):
    class_contents = {}
    class_codelist = {code.class_name: (code.pk) for code in Class_code.objects.all()}

    for class_code in class_codelist:
        class_contents[class_code] = [[u.class_number, u.user.firstname + " " + u.user.lastname, u.user.sex_code] for u in Class_assignment.objects.filter(class_code=class_codelist[class_code])]
    
    return export_excel(all_student_class(class_contents))

def all_student_export(request):
    class_contents = {}
    class_codelist = {code.class_name: (code.pk) for code in Class_code.objects.all()}

    #['Class', 'Class number', 'Student name', 'Sex code', 'Card id', 'Strn code', 'birthday', 'email']
    class_contents = [[u.class_code.class_name, u.class_number, u.user.firstname + " " + u.user.lastname, u.user.sex_code, u.user.card_id, u.user.strn_code, u.user.birth_date, u.user.email] for u in Class_assignment.objects.all().order_by('class_code')]
    
    return export_excel(all_student(class_contents))
  