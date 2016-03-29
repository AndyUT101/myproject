from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from datetime import datetime, timedelta
from django.core.exceptions import ObjectDoesNotExist

from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav

from .models import *
from .forms import *
from .utils import *
from user.models import User

# http://stackoverflow.com/questions/5871730/need-a-minimal-django-file-upload-example

def list_classroom(request):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))
    user = User.objects.get(username = request.session['user'])

    if review_permission(user, 'allow:classroom_all'):
        classroom = Classroom.objects.all()
        render_body = 'classroom_manage'
    else:
        classroom = tuple(i.classroom for i in User_assignment.objects.filter(user=user))
        classroom = tuple(c for c in classroom if c.status == 'O')
        render_body = 'classroom'

    return render(request, 'home.html', {
        'page_title': 'Classroom',
        'page_header': 'Classroom',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list', 
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
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not is_memberinfo(shortcode, request.session['user'])[0]:
        return HttpResponseRedirect(reverse('classroom:classroom_list'))

    c = get_contents(shortcode)

    return render(request, 'home.html', {
        'page_title': c['classroom'].name +':Classroom',
        'page_header': 'Classroom '+c['classroom'].name,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'testing', 
        'content': {
            'classroom': {
                'title': 'Classroom Portal',
                'count': get_contentscount(c),
                'right_nav': right_nav(shortcode),
                'right_notice': right_nav(shortcode),
            },
        },
    })


def announce(request, shortcode):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not is_memberinfo(shortcode, request.session['user'])[0]:
        return HttpResponseRedirect(reverse('classroom:classroom_list'))

    c = get_contents(shortcode)

    announce_data = c['announce'].order_by('-announce_date')

    return render(request, 'home.html', {
        'page_title': 'Announcement: '+c['classroom'].name,
        'page_header': 'Announcement: '+c['classroom'].name,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'classroom', 
        'content': {
            'shortcode': shortcode,
            'classroom': {
                'title': 'Recently announcement',
                'count': announce_count,
                'right_nav': right_nav(shortcode),
                'right_notice': right_nav(shortcode),
                'content': announce_data,
            },
        },
    })

def announce_all(request, shortcode):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])[0]
    if not memberinfo:
        return HttpResponseRedirect(reverse('classroom:classroom_list'))

    permission = allow_contentadd(memberinfo[1])

    announce = get_contents(shortcode)['announce']

    return render(request, 'home.html', {
        'page_title': 'All announcement: '+c['classroom'].name,
        'page_header': 'All announcement: '+c['classroom'].name,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {
            'permission': permission,
            'shortcode': shortcode,
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Add announcement', 
                   'url': 'classroom:announce_add',
                   'html_class': 'add_announcement'}),
            ),
            'list': {
                'name': 'announcement',
                'body': announce,
            },
        },
    })

def announce_add(request, shortcode):
    page_title = 'Add announcement'
    submit_url = 'classroom:announce_add'
    return_url = 'classroom:announce_all'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])[0]
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo or not permission:
        return HttpResponseRedirect(reverse(return_url))


    form_obj = AnnounceForm()
    if request.method == 'POST':
        form_obj = AnnounceForm(request.POST)

        if form_obj.is_valid():
            form_obj.save(commit=False)
            form_obj.classroom = Classroom.objects.get(shortcode = shortcode)
            form_obj.save()

            return render(request, 'home.html', {
                'page_title': page_title,
                'page_header': page_title,
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Announcement add successful',
                    'redirect_text': 'all announcement',
                    'redirect_url': return_url,
                    'auto_redirect': True,
                },
            })
        else:
            return render(request, 'home.html', {
                'page_title': page_title,
                'page_header': page_title,
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'form',
                'content': {
                    'form': form_obj.as_ul(),
                    'submit_url': submit_url,
                },
            })

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'form',
        'content': {
            'form': form_obj.as_ul(),
            'submit_url': submit_url,
        },
    })

def announce_del(request, shortcode):
    page_title = 'Remove announcement'
    return_url = 'classroom:announce_all'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])[0]
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo or not permission:
        return HttpResponseRedirect(reverse(return_url))

    delete_index = request.GET.get('delete', '')
    if not delete_index:
        return HttpResponseRedirect(reverse(return_url))

    # delete announce
    try:
        announce = Announce.objects.get(pk = delete_index)
    except ObjectDoesNotExist:
        return HttpResponseRedirect(reverse(return_url))

    announce.delete()

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'notification',
        'content': {
            'notification': 'Announcement delete successful',
            'redirect_text': 'all announcement',
            'redirect_url': return_url,
            'auto_redirect': True,
        },
    })

def assignment_list(request, shortcode):

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not is_memberinfo(shortcode, request.session['user'])[0]:
        return HttpResponseRedirect(reverse('classroom:classroom_list'))

    c = get_contents(shortcode)

    assignment_data = c['assignment'].order_by('-deadline_datetime')
    
    return render(request, 'home.html', {
        'page_title': 'Announcement: '+c['classroom'].name,
        'page_header': 'Announcement: '+c['classroom'].name,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'classroom', 
        'content': {
            'shortcode': shortcode,
            'classroom': {
                'title': 'Recently announcement',
                'count': announce_count,
                'right_nav': right_nav(shortcode),
                'right_notice': right_nav(shortcode),
                'content': assignment_data,
            },
        },
    })

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
