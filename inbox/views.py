from django.shortcuts import render
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound, Http404

from user.models import User
from .models import Inbox_content, Inbox, Inbox_classroom

from user.views import user_alreadyloggedin

# Create your views here.
def list_inboxmsg(request):
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

    user = User.objects.get(username=request.session['user'])
    inbox_msg = Inbox.objects.filter(receiver=user.pk)
    order_assign = inbox_msg.order_by('send_datetime')

    pass

def view_msg(request, msg_id = None):
    # check msg -> user_id == user_id, if fail, return
    if msg_id == None:
    	try:
    		Inbox.objects.get(pk = msg_id).filter() 
    raise Http404("Not yet logged in")
	pass


def send_msg(request, reply_id = None):
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

    # check reply_id -> user_id == user_id, if fail, return

    pass

def generate_msgform(request):
    if not user_alreadyloggedin(request):
        raise Http404("Not yet logged in")

    pass