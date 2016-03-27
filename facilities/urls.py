from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^$', views.index, name='index'),
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    # url(r'^login/$', views.login, name='login'),
    url(r'^$', views.list_facilities_floor, name='index'),
    url(r'^add/$', views.add_facilities, name='add'),
    url(r'^modify/(?P<facility_id>[0-9]+)$', views.modify_facilities, name='modify'),
    url(r'^delete/$', views.remove_facilities, name='delete'),

    url(r'^add_room/$', views.add_room, name='add_room'),]
    url(r'^delete_room/$', views.remove_room, name='remove_room'),
    url(r'^view_room/$', views.view_room, name='view_room'),

]
