from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from user.models import User
from .models import Inbox_content, Inbox, Inbox_classroom

from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav


# Create your views here.
def list_inboxmsg(request):
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

    # GET: ?page=page_num

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
            'adv_operation': ( 
                # operation pattern ('title', 'redirect_url(url:name)', 'assign html class name in list')
                ('Compose', 'inbox:compose', ['compose']),
                ('Delete', 'inbox:delete', ['delete']),

            ),
        },
    })

def view_msg(request, msg_id = None):
    """
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")
    # check msg -> user_id == user_id, if fail, return
    if msg_id == None:
        try:
            Inbox.objects.get(pk = msg_id).filter()
    """
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

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
        raise Http404("Not yet logged in")

    reply_mode = False
    user = User.objects.get(username=request.session['user'])

    # check reply_id -> user_id == user_id, if fail, return
    if not reply_id == None:
        try:
            reply_msg = Inbox.objects.get(pk=reply_id, receiver=user.pk)

        except ObjectDoesNotExist:
            pass

        reply_mode = True # Read "reply_msg" on after process

    return render(request, 'home.html', {
        'page_title': 'Reply message: Inbox',
        'page_header': 'Reply message',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'testing', # operation, form 
        'content': {
            'form': (),
            'submit_url': '',
        },
    });

    pass

def compose_view(request):
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

    pass

def delete_msg(request):
    pass