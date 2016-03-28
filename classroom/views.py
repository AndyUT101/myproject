from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.utils import user_alreadyloggedin, get_userrole
from siteinfo.views import site_topnav

# http://stackoverflow.com/questions/5871730/need-a-minimal-django-file-upload-example

def list_classroom(request):
    pass

def view_classroom(request, shortcode):
    pass

def announce(request, shortcode):
    pass

def announce_all(request, shortcode):
    pass

def announce_mod(request, shortcode):
    pass

def announce_del(request, shortcode):
    pass

def assignment_list(request, shortcode):
    pass

def assignment_add(request, shortcode):
    pass

def assignment_modify(request, shortcode):
    pass

def assignment_delete(request, shortcode):
    pass

def assignment_detail(request, shortcode):
    pass

def assignment_submit(request, shortcode):
    pass

def material(request, shortcode):
    pass

def material_upload(request, shortcode):
    pass

def material_remove(request, shortcode):
    pass

def note(request, shortcode):
    pass

def note_add(request, shortcode):
    pass

def note_modify(request, shortcode):
    pass

def note_remove(request, shortcode):
    pass

"""
announce
announce_all
announce_mod
announce_del
assignment_list
assignment_add
assignment_modify
assignment_delete
assignment_detail
assignment_submit
material
material_upload
material_remove
note
note_add
note_modify
note_remove
"""
