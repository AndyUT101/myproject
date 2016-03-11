# from django.shortcuts import render
from django.shortcuts import get_object_or_404, render
from django.http import HttpResponse

#https://djangogirlstaipei.gitbooks.io/django-girls-taipei-tutorial/content/django/views_and_urlconfs.html

def index(request):
    return HttpResponse('Index')

def login(request):
    return HttpResponse('Login page.')

def logout(request):
    return HttpResponse('Logout page.')