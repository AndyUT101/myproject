from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.utils import user_alreadyloggedin, get_userrole
from siteinfo.views import site_topnav

# http://stackoverflow.com/questions/5871730/need-a-minimal-django-file-upload-example

# Create your views here.
def list_classroom(request):
    pass

def view_classroom(request, shortcode):
    pass