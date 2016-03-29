from django.shortcuts import render, render_to_response
from django.http import HttpResponseBadRequest
from django import forms
from django.template import RequestContext
from user.models import User

import pyexcel.ext.xlsx
import django_excel as excel

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

def attendent_report(request, username=None, class_code=None, start_date='', end_date=''):
    pass
