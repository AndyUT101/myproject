from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.models import User
from .models import Inbox_content, Inbox

from .forms import *
from .utils import *

from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav

import math


# Create your views here.
def list_inboxmsg(request):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    ##### page parameter ####
    default_pagevalue = {'page': 1, 'row_count': 50}
    page_get = request.GET.get('page', default_pagevalue['page'])
    row_count_get = request.GET.get('row_count', default_pagevalue['row_count'])

    try:
        page = int(page_get)
        row_count = int(row_count_get)
    except ValueError:
        page = default_pagevalue['page']
        row_count = default_pagevalue['row_count']
    ##### e:page parameter ####

    # GET: order by parameter
    available_para = ('send_datetime', 'content', 'read')
    available_order = ('asc', 'desc')
    order_by_para = '-send_datetime'

    get_para = request.GET.get('by', '')
    get_order = request.GET.get('order', '')

    if get_para and get_order:
        if get_para in available_para:
            order_by_para = get_para
            if get_order in available_order:
                if get_order == available_order[1]:
                    order_by_para = '-' + order_by_para


    user = User.objects.get(username=request.session['user'])
    inbox_msg = Inbox.objects.filter(receiver=user.pk).order_by(order_by_para)

    message_count = inbox_msg.count()

    ##### page parameter ####
    max_page = math.ceil(message_count/row_count)
    if page > max_page and max_page > 0:
        return HttpResponseRedirect(reverse('inbox:inbox'))
    inbox_msg = inbox_msg[row_count*(page-1):row_count+row_count*(page-1)]
    ##### page parameter ####

    return render(request, 'home.html', {
        'page_header': 'Inbox',
        'template': 'list', # operation, list,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'content': {
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Compose', 
                   'url': 'inbox:compose',
                   'html_class': 'compose'}),
                ({'title':'Delete', 
                   'url': 'inbox:delete',
                   'html_class': 'delete'}),

            ),
            'list': {
                'checkbox': True,
                'name': 'inbox',
                'body': inbox_msg,
                'foot': (),
            },
            'page_nav': { 
                # operation pattern ('title', 'redirect_url(url:name)', 'assign html class name in list')
                'message': '',
                'page': {
                    'current_page': page,
                    'max_page': max_page,
                },
            },
        },
    })

def view_msg(request, msg_id = None):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if msg_id == None:
        return HttpResponseRedirect(reverse('inbox:inbox'))

    try: 
        user = User.objects.get(username=request.session['user'])
        msg = Inbox.objects.get(pk = msg_id, receiver = user.pk)

    except ObjectDoesNotExist:
        return HttpResponseRedirect(reverse('inbox:inbox'))

    if not msg.read:
        msg.read = True
        msg.save()

    return render(request, 'home.html', {
        'page_title': 'Inbox: '+ msg.content.title,
        'page_header': 'Inbox',
        'template': 'detail', # operation, list, 
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'content': {

            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Reply', 
                   'url': 'inbox:compose',
                   'para': msg_id,
                   'html_class': 'compose'}),
              
            'detail': ( # key: (header, content, redirect_url(route/None), html_class)
                ('Sent by', msg.sender.username, None, 'sender'),
                ('Title', msg.content.title, None, 'title'),
                ('Content', msg.content.content, None, 'content'),


            ),
            'adv_operation': ( 
                # operation pattern ('title', 'redirect_url(url:name)', 'assign html class name in list')
                ('Reply', 'inbox:compose', ['compose']),
                ('Delete', 'inbox:delete', ['delete']),
            ),
        },
    });

def send_msg(request, reply_id = None):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username=request.session['user'])
    if request.method == 'GET':

        reply_mode = False
        # check reply_id -> user_id == user_id, if fail, return
        if not reply_id == None:
            try:
                reply_msg = Inbox.objects.get(pk=reply_id, receiver=user.pk)

            except ObjectDoesNotExist:
                return HttpResponseRedirect(reverse('inbox:compose'))

            reply_mode = True # Read "reply_msg" on after process

        if reply_mode:
            form_data = {
                'receiver': reply_msg.sender.username,
                'title': 'Re: ' + reply_msg.content.title,
                'content': '\n\n\n\n\n#####\n>> Reply:\n' + reply_msg.content.title,
            }
            compose_form = ComposeForm(form_data)
        else:
            compose_form = ComposeForm()

        return render(request, 'home.html', {
            'page_title': 'Send message: Inbox',
            'page_header': 'Send message',
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
            'template': 'form', # operation, form 
            'content': {
                'form': compose_form.as_ul(),
                'submit_url': 'inbox:compose',
            },
        });

    if request.method == 'POST':

        compose_form = ComposeForm(request.POST)
        
        if compose_form.is_valid():

            # Insert message content
            message = compose_form.save()
            userlist = split_receiver(request.POST.get('receiver', ''))

            commit_list = []
            for receiver in userlist:
                commit_list.append(Inbox(sender=user, receiver=User.objects.get(username=receiver), content=message))

            Inbox.objects.bulk_create(commit_list);

            return render(request, 'home.html', {
                'page_title': 'Send message: Inbox',
                'page_header': 'Send message',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Message send successful to '+ ', '.join(userlist),
                    'redirect_text': 'inbox page',
                    'redirect_url': 'inbox:inbox',
                    'auto_redirect': True,
                },
            })

        else:
            return render(request, 'home.html', {
                'page_title': 'Reply message: Inbox',
                'page_header': 'Reply message',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'form', # operation, form 
                'content': {
                    'form': ComposeForm(request.POST).as_ul(),
                    'submit_url': 'inbox:compose',
                },
            });

def delete_msg(request):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    # 2. Check delete confirmation

    # 3. Collect checkbox list
    delete_list = request.POST.getlist('msg_action')

    # 4. Prevent for lower right users delete other greater right user
    # (Functional requirement)
    user = User.objects.get(username = request.session['user'])

    msg_removeobj = Inbox.objects.filter(pk__in=delete_list, receiver=user)

    if msg_removeobj.count() == len(delete_list):
        msg_removeobj.delete() #success
        return HttpResponse('msg removed.')

    else:
        return HttpResponse('fail removed.')
