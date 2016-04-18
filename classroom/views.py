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
        operation = ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Create classroom', 
                   'url': 'classroom:add_classroom',
                   'html_class': 'create_classroom'}),
        )
    else:
        classroom = tuple(i.classroom for i in User_assignment.objects.filter(user=user))
        classroom = tuple(c for c in classroom if c.status == 'O')
        render_body = 'classroom'
        operation = False

    return render(request, 'home.html', {
        'page_title': 'Classroom',
        'page_header': 'Classroom',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list', 
        'content': {
            'operation': operation,
            'list': {
                'name': render_body,
                'body': classroom,
                'foot': (),
            },
        },
    })

def create_classroom(request):
    page_title = 'Create classroom'
    submit_url = 'classroom:add_classroom'
    return_url = 'classroom:classroom_list'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))
    user = User.objects.get(username = request.session['user'])

    if not review_permission(user, 'allow:classroom_all'):
        return HttpResponseRedirect(reverse('classroom:classroom_list'))

    form_obj = ClassroomForm()
    if request.method == 'POST':
        form_obj = ClassroomForm(request.POST)

        if form_obj.is_valid():
            form_obj = form_obj.save(commit=False)
            form_obj.creator = user

            form_obj.save()
            User_assignment(user=user, role='ADM', classroom=form_obj).save()

            return render(request, 'home.html', {
                'page_title': page_title,
                'page_header': page_title,
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Classroom add successful',
                    'redirect_text': 'Classroom list',
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

def manage_classroom(request):
    # remove and on/off classroom
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
        'template': 'classroom', 
        'content': {
            'notification': {
                'current_classroom': c['classroom'].name,
                'classroom_role': role_tidyprint(is_memberinfo(shortcode, request.session['user'])[1]),
                'url': shortcode,
            },
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

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    if not memberinfo[0]:
        return HttpResponseRedirect(reverse('classroom:classroom_list')+shortcode)

    permission = allow_contentadd(memberinfo[1])
    c = get_contents(shortcode)

    announce_data = c['announce'].order_by('-announce_date')
    announce_count = len(announce_data)

    return render(request, 'home.html', {
        'page_title': 'All announcement',
        'page_header': 'All announcement',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {
            'permission': permission,
            'shortcode': shortcode,
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Add announcement', 
                   'url': 'classroom:announce_add',
                   'url_para': shortcode,
                   'html_class': 'add_announcement'}),
            ),
            'list': {
                'name': 'announcement',
                'body': announce_data,
            },
        },
    })

def announce_all(request, shortcode):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    if not memberinfo[0]:
        return HttpResponseRedirect(reverse('classroom:classroom_list')+shortcode)

    permission = allow_contentadd(memberinfo[1])
    c = get_contents(shortcode)

    announce_data = c['announce'].order_by('-announce_date')
    announce_count = len(announce_data)

    return render(request, 'home.html', {
        'page_title': 'All announcement',
        'page_header': 'All announcement',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {
            'permission': permission,
            'shortcode': shortcode,
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Add announcement', 
                   'url': 'classroom:announce_add',
                   'url_para': shortcode,
                   'html_class': 'add_announcement'}),
            ),
            'list': {
                'name': 'announcement',
                'body': announce_data,
            },
        },
    })

def announce_add(request, shortcode):
    page_title = 'Add announcement'
    submit_url = 'classroom:announce_add'
    return_url = 'classroom:announce_all'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0] or not permission:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))


    form_obj = AnnounceForm()
    if request.method == 'POST':
        form_obj = AnnounceForm(request.POST)

        if form_obj.is_valid():
            form_obj = form_obj.save(commit=False)
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
                    'redirect_para': shortcode,
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
                    'route_parameter': shortcode,
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
            'route_parameter': shortcode,
        },
    })

def announce_del(request, shortcode):
    page_title = 'Remove announcement'
    return_url = 'classroom:announce_all'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0] or not permission:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    delete_index = request.GET.get('delete', '')
    if not delete_index:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    # delete announce
    try:
        announce = Announce.objects.get(pk = delete_index)
    except ObjectDoesNotExist:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

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
            'redirect_para': shortcode,
            'auto_redirect': True,
        },
    })

def assignment_list(request, shortcode):
    page_title = 'Assignment list'
    return_url = 'classroom:assignment_list'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))
    
    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0]:
        return HttpResponseRedirect(reverse('classroom:classroom_list'))

    if allow_contentadd(memberinfo[1]):
        operation = ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Add assignment', 
                   'url': 'classroom:assignment_add',
                   'url_para': shortcode,
                   'html_class': 'add_assignment'}),

        )
    else:
        operation = False

    c = get_contents(shortcode)

    assignment_data = c['assignment'].order_by('-deadline_datetime')
    assignment_count = len(assignment_data)

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list', 
        'content': {
            'shortcode': shortcode,
            'operation': operation,
            'permission': permission,            
            'classroom': {
                'title': 'Recently assignment',
                'count': assignment_count,
                'right_nav': right_nav(shortcode),
                'right_notice': right_nav(shortcode),
                'content': assignment_data,
            },
            'list': {
                'name': 'assignment',
                'body': assignment_data, 
            },
        },
    })

def assignment_add(request, shortcode):
    page_title = 'Add assignment'
    submit_url = 'classroom:assignment_add'
    return_url = 'classroom:assignment_list'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0] or not permission:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))


    form_obj = AssignmentForm()
    if request.method == 'POST':
        form_obj = AssignmentForm(request.POST)

        if form_obj.is_valid():
            form_obj = form_obj.save(commit=False)
            form_obj.classroom = Classroom.objects.get(shortcode = shortcode)
            form_obj.save()

            return render(request, 'home.html', {
                'page_title': page_title,
                'page_header': page_title,
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Assignment add successful',
                    'redirect_text': 'all assignment',
                    'redirect_url': return_url,
                    'redirect_para': shortcode,
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
                    'route_parameter': shortcode,
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
            'route_parameter': shortcode,
        },
    })

def assignment_delete(request, shortcode):
    page_title = 'Remove assignment'
    return_url = 'classroom:assignment_list'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0] or not permission:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    delete_index = request.GET.get('delete', '')
    if not delete_index:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    # delete assignment
    try:
        assignment = Assignment.objects.get(pk = delete_index)
    except ObjectDoesNotExist:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    assignment.delete()

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'notification',
        'content': {
            'notification': 'Assignment delete successful',
            'redirect_text': 'all assignment',
            'redirect_url': return_url,
            'redirect_para': shortcode,
            'auto_redirect': True,
        },
    })

def assignment_detail(request, shortcode, assignment_id):
    page_title = 'Assignment detail'
    return_url = 'classroom:assignment_list'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0] or not classroom_has_assignment(shortcode, assignment_id):
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    assignment_obj = Assignment.objects.get(pk = assignment_id)

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'testing', 
        'content': {
            'classroom': {
                'title': 'Assignment detail',
                'content': assignment_obj,
            },
        },
    })

def assignment_submit(request, shortcode, assignment_id):
    page_title = 'Assignment submission'
    submit_url = 'classroom:assignment_submit'
    return_url = 'classroom:assignment_detail'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0] or not classroom_has_assignment(shortcode, assignment_id):
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    form_obj = Assignment_submitForm()
    if request.method == 'POST':
        form_obj = Assignment_submitForm(request.POST, request.FILES)

        if form_obj.is_valid():

            form_obj = form_obj.save(commit=False)
            form_obj.user_assign = user_assign_assignment(shortcode, request.session['user'])
            form_obj.assignment = Assignment.objects.get(pk=assignment_id)
            form_obj.save()

            return render(request, 'home.html', {
                'page_title': page_title,
                'page_header': page_title,
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Assignment submit successful',
                    'redirect_text': 'all assignment',
                    'redirect_url': return_url,
                    'redirect_para': shortcode,
                    'redirect_para2': assignment_id,
                    'auto_redirect': True,
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
                'route_parameter': shortcode,
                'route_parameter2': assignment_id,
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
            'route_parameter': shortcode,
            'route_parameter2': assignment_id,
        },
    })

def material(request, shortcode):
    page_title = 'View materials'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not is_memberinfo(shortcode, request.session['user'])[0]:
        return HttpResponseRedirect(reverse('classroom:classroom_list'))

    if allow_contentadd(memberinfo[1]):
        operation = ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Add material', 
                   'url': 'classroom:material_upload',
                   'url_para': shortcode,
                   'html_class': 'add_material'}),

        )
    else:
        operation = False

    classroom = Classroom.objects.get(shortcode=shortcode)
    material = Material_classroom.objects.filter(classroom = classroom)

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {
            'permission': permission,
            'operation': operation, 
            'shortcode':shortcode,
            'list': {
                'name': 'material',
                'body': material,
            },
        },
    })   

def material_upload(request, shortcode):
    page_title = 'Add material'
    submit_url = 'classroom:material_upload'
    return_url = 'classroom:material'
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0] or not permission:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    form_obj = MaterialForm()
    if request.method == "POST":
        form_obj = MaterialForm(request.POST, request.FILES)

        if form_obj.is_valid():

            form_obj = form_obj.save(commit=False)

            classroom = Classroom.objects.get(shortcode = shortcode)
            user = User.objects.get(username = request.session['user'])
            user_assign = User_assignment.objects.get(classroom = classroom, user = user)

            form_obj.uploader = user_assign
            form_obj.create_date = timezone.now()
            form_obj.save()

            Material_classroom(material = form_obj, classroom = classroom).save()


            return render(request, 'home.html', {
                'page_title': page_title,
                'page_header': page_title,
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Material uploaded successful',
                    'redirect_text': 'all materials',
                    'redirect_url': return_url,
                    'redirect_para': shortcode,
                    'auto_redirect': True,
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
            'route_parameter': shortcode,
        },
    })


def material_remove(request, shortcode):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    delete_index = request.GET.get('delete', '')
    if not delete_index:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    del_item = Material_classroom.objects.get(pk = delete_index)
    del_item.delete()

    return render(request, 'home.html', {
        'page_title': 'Remove material',
        'page_header': 'Remove material',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'notification',
        'content': {
            'notification': 'material removes successful',
            'redirect_text': 'material page',
            'redirect_url': 'classroom:material',
            'redirect_para': shortcode,
            'auto_redirect': True,
        },
    })


def note(request, shortcode):
    page_title = 'View notes'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])

    if not is_memberinfo(shortcode, request.session['user'])[0]:
        return HttpResponseRedirect(reverse('classroom:classroom_list'))

    if allow_contentadd(memberinfo[1]):
        operation = ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Add note', 
                   'url': 'classroom:note_add',
                   'url_para': shortcode,
                   'html_class': 'add_note'}),

        )
    else:
        operation = False

    classroom = Classroom.objects.get(shortcode=shortcode)
    note = Classroom_note.objects.filter(classroom = classroom).order_by('-note.publish_datetime')

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {
            'shortcode': shortcode,
            'operation': operation,
            'list': {
                'name': 'note',
                'body': note,
            },
        },
    })

def note_add(request, shortcode):
    page_title = 'Add note'
    submit_url = 'classroom:note_add'
    return_url = 'classroom:note'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    memberinfo = is_memberinfo(shortcode, request.session['user'])
    permission = allow_contentadd(memberinfo[1])

    if not memberinfo[0] or not permission:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))


    form_obj = NoteForm()
    if request.method == 'POST':
        form_obj = NoteForm(request.POST)

        if form_obj.is_valid():
            form_obj = form_obj.save(commit=False)
            classroom = Classroom.objects.get(shortcode = shortcode)
            form_obj.classroom = classroom
            form_obj.save()

            Classroom_note(classroom = classroom, note = form_obj).save()


            return render(request, 'home.html', {
                'page_title': page_title,
                'page_header': page_title,
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Note add successful',
                    'redirect_text': 'all note',
                    'redirect_url': return_url,
                    'redirect_para': shortcode,
                    'auto_redirect': True,
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
            'route_parameter': shortcode,
        },
    })

def note_modify(request, shortcode, note_id):
    pass

def note_remove(request, shortcode):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    delete_index = request.GET.get('delete', '')
    if not delete_index:
        return HttpResponseRedirect(reverse(return_url, args=[shortcode]))

    del_item = Material_classroom.objects.get(pk = delete_index)
    del_item.delete()

    note = Note.objects.get(pk=note_id)
    note.delete()

    return render(request, 'home.html', {
        'page_title': 'Remove note',
        'page_header': 'Remove note',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'notification',
        'content': {
            'notification': 'Note removes successful',
            'redirect_text': 'note page',
            'redirect_url': 'classroom:note',
            'auto_redirect': True,
        },
    })
