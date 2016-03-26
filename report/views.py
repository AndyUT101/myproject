from django.shortcuts import render
from user.models import User

import pyexcel.ext.xlsx

# Create your views here.
# helper function
def list_report():
    pass

def generate_report(request):
    user_dataset = User.objects.all()
    column_name = ['pk', 'username', 'firstname', 'lastname']
    return excel.make_response_from_query_sets(user_dataset, column_name, 'xlsx', file_name="custom")

def attendent_report(request, username=None, class_code=None, start_date='', end_date=''):
    pass