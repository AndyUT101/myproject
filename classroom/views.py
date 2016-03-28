from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav

# http://stackoverflow.com/questions/5871730/need-a-minimal-django-file-upload-example

def list_classroom(request):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))
    user = User.objects.get(username = request.session['user'])

    if review_permission(user, 'allow:classroom_all'):
        classroom = Classroom.objects.all()
        render_body = 'classroom_manage'
    else:
        classroom = tuple(i.classroom for i in User_assignment.objects.filter(user=user, status='O'))
        render_body = 'classroom'  
    return render(request, 'home.html', {
        'page_title': 'Classroom',
        'page_header': 'Classroom',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list', # operation, list, 
        'content': {
            'list': {
                'name': render_body,
                'body': classroom,
                'foot': (),
            },
        },
    })

def manage_classroom(request):
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
