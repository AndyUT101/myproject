from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    url(r'^$', views.list_classroom, name='classroom_list'),
    url(r'^(?P<shortcode>.+)/$', views.view_classroom , name='classroom'),
    url(r'^(?P<shortcode>.+)/announce/$', views.announce, name='announce'),
    url(r'^(?P<shortcode>.+)/announce_all/$', views.announce_all, name='announce_all'),
    url(r'^(?P<shortcode>.+)/announce_mod/$', views.announce_mod, name='announce_mod'),
    url(r'^(?P<shortcode>.+)/announce_del/$', views.announce_del, name='announce_del'),
    url(r'^(?P<shortcode>.+)/assignment_list/$', views.assignment_list, name='assignment_list'),
    url(r'^(?P<shortcode>.+)/assignment_add/$', views.assignment_add, name='assignment_add'),
    url(r'^(?P<shortcode>.+)/assignment_modify/$', views.assignment_modify, name='assignment_modify'),
    url(r'^(?P<shortcode>.+)/assignment_delete/$', views.assignment_delete, name='assignment_delete'),
    url(r'^(?P<shortcode>.+)/assignment_detail/$', views.assignment_detail, name='assignment_detail'),
    url(r'^(?P<shortcode>.+)/assignment_submit/$', views.assignment_submit, name='assignment_submit'),
    url(r'^(?P<shortcode>.+)/material/$', views.material, name='material'),
    url(r'^(?P<shortcode>.+)/material_upload/$', views.material_upload, name='material_upload'),
    url(r'^(?P<shortcode>.+)/material_remove/$', views.material_remove, name='material_remove'),
    url(r'^(?P<shortcode>.+)/note/$', views.note, name='note'),
    url(r'^(?P<shortcode>.+)/note_add/$', views.note_add, name='note_add'),
    url(r'^(?P<shortcode>.+)/note_modify/$', views.note_modify, name='note_modify'),
    url(r'^(?P<shortcode>.+)/note_remove/$', views.note_remove, name='note_remove')
]

"""
view
announce
announce_all
announce_mod
announce_del
assignment_list
assignment_add
assignment_modify
assignment_delete
assignment_detail
assignment_submit
material
material_upload
material_remove
note
note_add
note_modify
note_remove
"""


