from django.conf.urls import url

from . import views

urlpatterns = [
    #url(r'^$', views.index, name='index'),
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    url(r'^login/$', views.login, name='login'),
    url(r'^logout/$', views.logout, name='logout'),

    url(r'^delete/$', views.remove_user, name='remove_user'),
    url(r'^add/$', views.add_user, name='add_user'),

    url(r'^modify/(?P<username>.+)/$', views.modifyuser_view, name='modify_user_view'),
    url(r'^modify/process/$', views.modify_user, name='modify_user'),
    # url(r'^(?P<process>.+)/(?P<specific_id>[0-9]+)$', views.edituser_view, name='edit_user'),
    url(r'^$', views.list_user, name='list_user'),
    url(r'^(?P<user>.+)/$', views.view_user, name='view_user'),
]
