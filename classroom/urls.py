from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    url(r'^$', views.list_classroom, name='classroom_list'),
    url(r'^add/$', views.create_classroom, name='add_classroom'),
    url(r'^manage/$', views.manage_classroom, name='manage'),
    url(r'^(?P<shortcode>.+)/announce/$', views.announce, name='announce'),
    url(r'^(?P<shortcode>.+)/announce_all/$', views.announce_all, name='announce_all'),
    url(r'^(?P<shortcode>.+)/announce_add/$', views.announce_add, name='announce_add'),
    url(r'^(?P<shortcode>.+)/announce_del/$', views.announce_del, name='announce_del'),
    url(r'^(?P<shortcode>.+)/assignment_list/$', views.assignment_list, name='assignment_list'),
    url(r'^(?P<shortcode>.+)/assignment_add/$', views.assignment_add, name='assignment_add'),
    url(r'^(?P<shortcode>.+)/assignment_delete/$', views.assignment_delete, name='assignment_delete'),
    url(r'^(?P<shortcode>.+)/assignment_detail/(?P<assignment_id>[0-9]+)/$', views.assignment_detail, name='assignment_detail'),
    url(r'^(?P<shortcode>.+)/assignment_submit/(?P<assignment_id>[0-9]+)/$', views.assignment_submit, name='assignment_submit'),
    url(r'^(?P<shortcode>.+)/assignment_status/(?P<assignment_id>[0-9]+)/$', views.assignment_submitstatus , name='assignment_submitstatus'),
    url(r'^(?P<shortcode>.+)/material/$', views.material, name='material'),
    url(r'^(?P<shortcode>.+)/material_upload/$', views.material_upload, name='material_upload'),
    url(r'^(?P<shortcode>.+)/material_remove/$', views.material_remove, name='material_remove'),
    url(r'^(?P<shortcode>.+)/note/$', views.note, name='note'),
    url(r'^(?P<shortcode>.+)/note_add/$', views.note_add, name='note_add'),
    url(r'^(?P<shortcode>.+)/note_remove/$', views.note_remove, name='note_remove'),

    url(r'^(?P<shortcode>.+)/user/remove/(?P<user_assign_id>[0-9]+)/$', views.remove_cmmember, name='remove_cmmember'),
    url(r'^(?P<shortcode>.+)/user/$', views.modify_cmmember, name='modify_cmmember'),
    url(r'^(?P<shortcode>.+)/user/add/$', views.add_cmmember, name='add_cmmember'),



    url(r'^(?P<shortcode>.+)/$', views.view_classroom , name='classroom'),

    

]
