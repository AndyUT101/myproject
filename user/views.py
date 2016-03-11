# from django.shortcuts import render
from django.shortcuts import get_object_or_404, render
from django.http import HttpResponse
from passlib.hash import md5_crypt

import random, string

#https://djangogirlstaipei.gitbooks.io/django-girls-taipei-tutorial/content/django/views_and_urlconfs.html

def generate_token(length = 8):
    """
    Generate random token for session
    """
    random_string = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(length))

    return md5_crypt.encrypt(random_string)
    
# cookies
# http://dokelung-blog.logdown.com/posts/222552-django-notes-9-cookies-and-sessions

def index(request):
    if 'token' in request.session:
        return HttpResponse('Index, session_id =' + request.session['token'])

    return HttpResponse('Index')

def login(request):
    if 'token' not in request.session:
        session_timeout_minutes = 30
        request.session.set_expiry(session_timeout_minutes * 60)
        request.session['token'] = generate_token()

    return HttpResponse('Login page')

def logout(request):
    del request.session['token']
    return HttpResponse('Logout page')
