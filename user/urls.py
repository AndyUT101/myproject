from django.conf.urls import url

from . import views

urlpatterns = [
    #url(r'^$', views.index, name='index'),
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    url(r'^login/$', views.login, name='login'),
    url(r'^logout/$', views.logout, name='logout'),

    url(r'^delete/$', views.remove_user, name='remove_user'),
    url(r'^add/$', views.add_user, name='add_user'),

    url(r'^modify/$', views.modify_user, name='modify_user'),
    url(r'^class/$', views.class_assign, name='class_assign'),
    url(r'^modify/(?P<username>.+)/$', views.modify_user, name='modify_user'),
    url(r'^$', views.list_user, name='list_user'),
    url(r'^(?P<username>.+)/$', views.view_user, name='view_user'),

]
