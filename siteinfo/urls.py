from django.conf.urls import url

from . import views

urlpatterns = [
    # url(r'^$', views.index, name='index'),
    # url(r'^(?P<process>.+)/(?P<user_id>[0-9]+)$', views.modify, name='modify'),
    # url(r'^login/$', views.login, name='login'),
    # url(r'^$', views.generate_report, name='index')
    url(r'^$', views.site_overview, name='overview'),
    url(r'^sitemap_view$', views.sitemap_view, name='sp_view'),
    url(r'^sitemap_edit$', views.sitemap_edit, name='sp_edit'),
    url(r'^sitemap_delete$', views.sitemap_delete, name='sp_del'),
    url(r'^sitemap_add$', views.sitemap_delete, name='sp_add'),
]
