from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^$', views.index, name='index'),
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    # url(r'^login/$', views.login, name='login'),
    url(r'^$', views.list_report, name='index'),
    url(r'^attend/$', views.attend_form, name='attend_form'),
    url(r'^attend/(?P<attend_date>.+)/(?P<class_pk>[0-9]+)$', views.attend_export, name='attend_export'),
    url(r'^all_stu/$', views.generate_report, name='all_student'),
    url(r'^class_stu/(?P<class_name>.+)$', views.generate_class_report, name='class_report')
]
