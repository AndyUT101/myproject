from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.utils import user_alreadyloggedin, get_userrole
from siteinfo.views import site_topnav

import json

# Create your views here.
def rule_list(request):
    pass

def rollcall(request):
    response_data = {}

    if request.method == 'GET':
        response_data['status'] = False
        response_data['message'] = 'Please use POST to send the rollcall data'

    elif request.method == 'POST':
        response_data['status'] = False
        response_data['message'] = 'No data received'


    return HttpResponse(json.dumps(response_data), content_type="application/json")
