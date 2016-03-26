from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound, Http404
from django.core.urlresolvers import reverse

from django.core.exceptions import ObjectDoesNotExist
from django.db.utils import IntegrityError

from .models import Schoolinfo, Sitemap

# Create your views here.
def management_panel(request):
    pass

def site_overview(request):
    pass

def site_topnav(user_level = 1):
    sitemap_obj = Sitemap.objects.all().filter(level__lte=user_level).order_by('order')
    obj = [{'title': item.title, 'url_route': item.url_route, 'pk': item.pk, 'top_level': item.top_level, 'level': item.level} for item in sitemap_obj]

    d = {'main':[], 'sub':[]}
    for item in obj:
        if item['top_level'] == None:
            d['main'].append(item)
            del item['top_level']
        else:
            d['sub'].append(item)

    for item in d['sub']:
        for core in d['main']:
            if core['pk'] == item['top_level'].pk:
                if not 'sub_menu' in core:
                    core['sub_menu'] = [item]
                else:
                    core['sub_menu'].append(item)
                continue
        del item['top_level']

    return d['main']