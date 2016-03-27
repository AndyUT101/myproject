from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    url(r'^$', views.list_inboxmsg, name='inbox'),
    url(r'^msg/(?P<msg_id>[0-9]+)', views.view_msg, name='view'),

    url(r'^compose/$', views.send_msg, name='compose'),
    url(r'^delete/$', views.delete_msg, name='delete'),
]
