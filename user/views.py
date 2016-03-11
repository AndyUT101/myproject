# from django.shortcuts import render
from django.shortcuts import get_object_or_404, render
from django.http import HttpResponse
from passlib.hash import md5_crypt

#https://djangogirlstaipei.gitbooks.io/django-girls-taipei-tutorial/content/django/views_and_urlconfs.html

def generate_token(self, length = 8):
    return ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(length))

def index(request):
    if 'token' in request.session:
        return HttpResponse('Index, session_id =' + token)

    return HttpResponse('Index')

def login(request):
    if 'token' not in request.session:
        request.session['token'] = md5_crypt.encrypt(generate_token)

    return HttpResponse('Login page.')

def logout(request):
    return HttpResponse('Logout page.')

