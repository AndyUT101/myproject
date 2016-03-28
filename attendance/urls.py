from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^$', views.index, name='index'),
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    # url(r'^login/$', views.login, name='login'),
    # url(r'^$', views.generate_report, name='index')
    url(r'^$', views.rule_list, name='rulelist'),
    url(r'^add_rule$', views.add_rule, name='add_rule'),
    url(r'^apply_rule$', views.apply_rule, name='apply_rule'),
    url(r'^view_rule$', views.view_rule, name='view_rule'),

    url(r'^remove_rule/(?P<rule_id>[0-9]+)$', views.remove_rule, name='remove_rule'),
    url(r'^edit_rule/(?P<rule_id>[0-9]+)$', views.edit_rule, name='edit_rule'),


]
