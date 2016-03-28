from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist
from django.views.decorators.csrf import csrf_exempt

from user.utils import user_alreadyloggedin, get_userrole
from siteinfo.views import site_topnav

import json
from datetime import datetime

from .models import *
from user.models import User

# Create your views here.
def rule_list(request):
    pass

@csrf_exempt
def rollcall(request):
    response_data = {}

    if request.method == 'GET':
        response_data['status'] = False
        response_data['message'] = 'Please use POST to send the rollcall data'

    elif request.method == 'POST':
        card_id = request.POST.get('card_id', '')
        token = 'b8293a1035a1c929105ea870ecbef6f8'
        received_token = request.POST.get('token', '') == token

        response_data['status'] = False
        response_data['message'] = 'Unknown situation'

        if not card_id:
            response_data['status'] = False
            response_data['message'] = 'No data received'

        
        if not received_token:
            response_data['status'] = False
            response_data['message'] = 'Illegal access'

        if received_token and card_id:
            try:
                user = User.objects.get(card_id=card_id)
            except ObjectDoesNotExist:
                response_data['status'] = False
                response_data['message'] = 'No user record'

            Attandance(user=user).save()

            response_data['status'] = True
            response_data['message'] = 'Attandance logged'
            response_data['user'] = user.username
            response_data['datetime'] = datetime.now()


    return HttpResponse(json.dumps(response_data), content_type="application/json")
