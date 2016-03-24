from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    url(r'^$', views.list_inboxmsg, name='inbox'),

    url(r'^compose/$', views.compose_view, name='compose'),
    url(r'^send/$', views.send_msg, name='send'),
]
