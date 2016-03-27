from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav

from user.models import User
from .models import Facilities, Room
from .forms import *

def list_facilities_floor(request):

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username = request.session['user'])
    if not review_permission(user, 'allow:facilities_view'):
        return HttpResponseRedirect(reverse('index_home'))

    facilities_obj = Facilities.objects.all().order_by('room')

    return render(request, 'home.html', {
        'page_title': 'Welcome home!',
        'page_header': 'Good to seeing you, ',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {   
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Assign facility', 
                   'url': 'facilities:add',
                   'html_class': 'assign_facility'}),

                ({'title':'Delete facility', 
                   'url': 'facilities:delete',
                   'html_class': 'delete_facility'}),

                ({'title':'Add room information', 
                   'url': 'facilities:add_room',
                   'html_class': 'add_room'}),
            ),
            'list': {
                'name': 'facilities',
                'body': facilities_obj,
            },
        },
    })



def add_facilities(request):
    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username = request.session['user'])
    if not review_permission(user, 'allow:facilities_add'):
        return HttpResponseRedirect(reverse('index_home'))

    # 2. Check GET or POST method
    if request.method == 'GET':

        return render(request, 'home.html', {
            'page_title': 'Add facilities',
            'page_header': 'Add facilities',
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
            'template': 'form',
            'content': {
                'form': FacilitiesForm().as_ul(),
                'submit_url': 'facilities:add',
            },
        })

    elif request.method == 'POST':

        facilities = FacilitiesForm(request.POST)

        if facilities.is_valid():
            facilities.save()

            return render(request, 'home.html', {
                'page_title': 'Add facilities',
                'page_header': 'Add facilities',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Facility add successful',
                    'redirect_text': 'Facilities page',
                    'redirect_url': 'facilities:index',
                    'auto_redirect': True,
                },
            })
        else:
            return render(request, 'home.html', {
                'page_title': 'Add facilities',
                'page_header': 'Add facilities',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'form',
                'content': {
                    'form': FacilitiesForm(request.POST).as_ul(),
                    'submit_url': 'facilities:add',
                },
            })

def modify_facilities(request, facility_id):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    # 1. User have right to edit itself, else check for permission key
    if not review_permission(User.objects.get(username = request.session['user']), 'allow:facilities_edit'):
        return HttpResponseRedirect(reverse('facilities:index'))


    # 2. Check GET or POST method
    if request.method == 'GET':
        
        # 3. (GET) Check user exist
        try:
            facility = Facilities.objects.get(pk = facility_id)
        except ObjectDoesNotExist:
            return HttpResponseRedirect(reverse('facilities:index'))

        # 4. (GET) Return userform
        return render(request, 'home.html', {
            'page_title': 'Modify facility',
            'page_header': 'Modify facility',
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
            'template': 'form',
            'content': {
                'form': FacilitiesForm(instance=facility).as_ul(),
                'submit_url': 'facilities:modify',
                'route_parameter': facility_id,
            },
        })
        

    elif request.method == 'POST':
        
        # 3. Replace original password if request.POST get empty password_hash
        modify_facilityobj = Facilities.objects.get(pk = facility_id)

        # 3. (POST) Field check
        facility_form = FacilitiesForm(request.POST, instance=modify_facilityobj)


        if facility_form.is_valid():
            commit_form =  facility_form.save(commit=False)
            commit_form.save()

            # 5. Return success page
            return render(request, 'home.html', {
                'page_title': 'Modify facility',
                'page_header': 'Modify facility',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Facility modify successful',
                    'redirect_text': 'Facility page',
                    'redirect_url': 'facilities:index',
                    'auto_redirect': True,
                },
            })

        else:
            # 5. Return userform
            return render(request, 'home.html', {
                'page_title': 'Modify facility',
                'page_header': 'Modify facility',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'form',
                'content': {
                    'form': FacilitiesForm(request.POST).as_ul(),
                    'submit_url': 'facilities:modify',
                    'route_parameter': facility_id,
                },
            })

    else:
        return HttpResponseRedirect(reverse('facilities:index'))

def remove_facilities(request):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    # 1. User have right to edit itself, else check for permission key
    if not review_permission(User.objects.get(username = request.session['user']), 'allow:facilities_delete'):
        return HttpResponseRedirect(reverse('facilities:index'))

    # 2. Check delete confirmation
    if not request.POST.get('remove_confirm', ''):
        return HttpResponseRedirect(reverse('facilities:index'))

    # 3. Collect checkbox list
    delete_list = request.POST.getlist('facilities_action')

    # 4. Prevent for lower right users delete other greater right user
    # (Functional requirement)
    user = User.objects.get(username = request.session['user'])

    facility_removeobj = Facilities.objects.filter(pk__in=delete_list, receiver=user)

    if facility_removeobj.count() == len(delete_list):
        facility_removeobj.delete() #success
        return render(request, 'home.html', {
            'page_title': 'Remove facilities',
            'page_header': 'Remove facilities',
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
            'template': 'notification',
            'content': {
                'notification': 'Facility remove successful',
                'redirect_text': 'Facilities page',
                'redirect_url': 'facilities:index',
                'auto_redirect': True,
            },
        })

    else:
        return render(request, 'home.html', {
            'page_title': 'Remove facilities',
            'page_header': 'Remove facilities',
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
            'template': 'notification',
            'content': {
                'notification': 'Illgal performs.',
                'redirect_text': 'Facilities page',
                'redirect_url': 'facilities:index',
                'auto_redirect': True,
            },
        })


def add_room(request):
    pass

def remove_room(request):
    pass

def view_room(request):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username = request.session['user'])
    if not review_permission(user, 'allow:facilities_view'):
        return HttpResponseRedirect(reverse('index_home'))

    room_obj = Room.objects.all().order_by('plate_name')

    return render(request, 'home.html', {
        'page_title': 'Room',
        'page_header': 'School room information',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {   
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Assign facility', 
                   'url': 'facilities:add',
                   'html_class': 'assign_facility'}),

                ({'title':'Delete facility', 
                   'url': 'facilities:delete',
                   'html_class': 'delete_facility'}),

                ({'title':'Add room information', 
                   'url': 'facilities:add_room',
                   'html_class': 'add_room'}),
            ),
            'list': {
                'name': 'room',
                'body': room_obj,
            },
        },
    })

