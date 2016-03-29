from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^$', views.index, name='index'),
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    # url(r'^login/$', views.login, name='login'),
    # url(r'^$', views.generate_report, name='index')
    url(r'^$', views.room_booked, name='index'),
    url(r'^reserve/$', views.book_room, name='reserve'),
    url(r'^reserve/delete/(?P<booking_id>[0-9]+)$', views.remove_book_room, name='delete'),
    url(r'^$all/', views.all_booking, name='all'),
]
