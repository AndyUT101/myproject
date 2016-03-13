# from django.shortcuts import render
from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect
from django.core.exceptions import ObjectDoesNotExist

from django.contrib.auth.hashers import check_password, make_password

from .models import User

import random, string

#https://djangogirlstaipei.gitbooks.io/django-girls-taipei-tutorial/content/django/views_and_urlconfs.html
# Helper function

def generate_token(length = 8):
    """
    Generate random token for session
    """
    random_string = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(length))

    return make_password(random_string, hasher='md5')[4:]

def review_permission(user, permission):
    pass
    
# cookies
# http://dokelung-blog.logdown.com/posts/222552-django-notes-9-cookies-and-sessions

def index(request):
    if 'token' in request.session:
        return HttpResponse('Index, session_id =' + request.session['token'])

    return render(request, 'login.html', {'error_message': 'index'})

def login(request):
    redirect_page = 'index'

    # Review login session status
    already_logged = False
    if 'token' in request.session:
        already_logged = True

        # Break process, return to index page
        return render(request, 'login.html', {
            'error_message': "Already logged, token:"+request.session['token'],
        })

    # Login authentication
    login_account = request.POST.get('account', '')
    login_password = request.POST.get('password', '')

    if not (login_account or login_password):
        ## Skip database process, return index page
        return render(request, 'login.html', {
			'error_message': "Empty username or password.",
		})
        
    ## Access database for user data
    try:
        user_object = User.objects.get(username = login_account)

    except ObjectDoesNotExist:
        return render(request, 'login.html', {
            'error_message': "No such user.",
        })

    ## Check password hash, assign session for logged user
    if check_password(login_password, user_object.password_hash):
        if not already_logged:
            session_timeout_minutes = 30
            request.session.set_expiry(session_timeout_minutes * 60)
            request.session['token'] = generate_token()

        # Redirect to page
        # return render(request, 'login.html', {
        #    'error_message': "Successful logged.",
        # })
        return HttpResponseRedirect('/user/')

    return render(request, 'login.html', {
           'error_message': "Fail to login.",
        })

def logout(request):
    if 'token' in request.session:
        del request.session['token']
    return HttpResponse('Logout page')

def add_user(request):
    pass

def remove_user(request):
    pass

def modify_user(request, user_id):

    return HttpResponse(user_id)

    #review_permission()

def view_user(request, user_id):
    pass

def list_user(request, page=1, row_count=50):
    pass

