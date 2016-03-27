from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.models import User

from user.utils import user_alreadyloggedin, get_userrole
from siteinfo.views import site_topnav

# Helper function
def calendar_list(request):
    # parameter: user
    pass

def is_clash_event(one_event_id, another_event_id, same_calender=True):
    # return True/False
    pass


def add_event(request):
    # parameter: datatime, user
    pass

def modify_event(request, event_id):
    pass

def remove_event(request, event_id):
    pass