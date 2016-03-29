from django.shortcuts import render, render_to_response
from django.http import HttpResponseBadRequest
from django import forms
from django.template import RequestContext
from user.models import User

import pyexcel.ext.xlsx
import django_excel as excel

from .forms import *

from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav

# Django-excel
# http://django-excel.readthedocs.org/en/latest/


# Create your views here.
# helper function
def list_report(request):
    pass

def generate_report(request):
    user_dataset = User.objects.all()
    column_name = ['pk', 'username', 'firstname', 'lastname', 'role.name']
    return excel.make_response_from_query_sets(user_dataset, column_name, 'xlsx', file_name="custom")

def attend_form(request):
    form_obj = Report_attend()

    if request.method == 'POST':
        form_obj = Report_attend(Request.POST)
        if form_obj.is_valid():
            class_pk = form_obj['class_pk']
            attend_date = form_obj['attend_date']


    return render(request, 'home.html', {
        'page_title': 'Attendance report today',
        'page_header': 'Attendance report today',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'form',
        'content': {
            'form': form_obj.as_ul(),
            'submit_url': 'report:attend_form',
        },
    })
