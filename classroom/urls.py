from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    url(r'^$', views.list_classroom, name='classroom_list'),
    url(r'^(?P<shortcode>.+)$', views.view_classroom, name='classroom'),
]