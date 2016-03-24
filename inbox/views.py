from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound, Http404

from user.models import User
from .models import Inbox_content, Inbox, Inbox_classroom

from user.views import user_alreadyloggedin

# Create your views here.
def list_inboxmsg(request):
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

    # GET: ?page=page_num

    user = User.objects.get(username=request.session['user'])
    inbox_msg = Inbox.objects.filter(receiver=user.pk).order_by('-send_datetime')

    message_count = inbox_msg.count()

    return render(request, 'home.html', {
        'page_header': 'Inbox',
        'template': 'list', # operation, list, 
        'content': {
            'operation': ( 
                # operation pattern ('title', 'redirect_url(url:name)', 'assign html class name in list')
                ('Compose', 'inbox:compose', ['compose']),
                ('Delete', 'inbox:delete', ['delete']),

            ),
            'list': {
                'checkbox': True,
                'header': (
                # list pattern ('title', 'models field')
                    ('', ('read')), 
                    ('Subject', ('content', 'title')),
                    ('Sender', ('sender', 'username')), 
                    ('Send Date', ('send_datetime')), 
                ),
                'body': inbox_msg,
                'foot': (),
            },
            'operation2': '',
        },
    })


    pass

def view_msg(request, msg_id = None):
    """
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")
    # check msg -> user_id == user_id, if fail, return
    if msg_id == None:
        try:
            Inbox.objects.get(pk = msg_id).filter()
    """
    pass

def send_msg(request, reply_id = None):
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

    # check reply_id -> user_id == user_id, if fail, return

    pass

def compose_view(request):
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

    pass

def delete_msg(request):
    pass