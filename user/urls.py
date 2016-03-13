from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index'),
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    url(r'^login/$', views.login, name='login'),
    url(r'^logout/$', views.logout, name='logout'),
    url(r'^modify/(?P<user_id>[0-9]+)$', views.modify, name='modify_user'),
    url(r'^delete/(?P<user_id>[0-9]+)$', views.modify, name='remove_users'),
    url(r'^add/$', views.modify, name='add_user'),


]
