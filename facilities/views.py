from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.utils import user_alreadyloggedin, get_userrole
from siteinfo.views import site_topnav

def list_facilities_floor(request):
    pass
    # case 1: return all facilities with floor
    # case 2: return specific floor facilities
    # case 3: return facilities status

def add_facilities(request):
    pass

def modify_facilities(request):
    pass

def remove_facilities(request):
    pass