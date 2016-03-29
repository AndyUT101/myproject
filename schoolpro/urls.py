"""schoolpro URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.9/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import include, url
from django.contrib import admin

from user.views import index, index_home 
from siteinfo.views import site_overview
from attendance.views import rollcall

urlpatterns = [
    url(r'^$', index, name='index'),
    url(r'^home/$', index_home, name='index_home'),

    url(r'^management/$', site_overview, name='overview'),
    url(r'^rollcall/$', rollcall, name='rollcall'),

    url(r'^attendance/', include('attendance.urls', namespace="attendance")),
    url(r'^booking/', include('booking.urls', namespace="booking")),
    url(r'^classroom/', include('classroom.urls', namespace="classroom")),
    url(r'^facilities/', include('facilities.urls', namespace="facilities")),
    url(r'^inbox/', include('inbox.urls', namespace="inbox")),
    url(r'^report/', include('report.urls', namespace="report")),
    url(r'^siteinfo/', include('siteinfo.urls', namespace="siteinfo")),
    url(r'^timetable/', include('timetable.urls', namespace="timetable")),
    url(r'^user/', include('user.urls', namespace="user")),

    url(r'^admin/', admin.site.urls),
]
