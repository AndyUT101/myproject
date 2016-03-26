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

def site_topnav(request, user_level = 1):
    output = []
    sitemap_obj = Sitemap.objects.all().order_by('order', 'level')
    obj = [{'title': item.title, 'url_route': item.url_route, 'pk': item.pk, 'top_level': item.top_level, 'level': item.level} for item in sitemap_obj]

    for item in obj:
        if item['level'] > user_level:
            continue

        if item['top_level'] == None:
            del item['top_level']
            output.append(item)
        else:
            output_index = len(output) - 1
            del item['top_level']
            if not 'sub_menu' in output[output_index]:
                output[output_index]['sub_menu'] = [item]
            else:
                output[output_index]['sub_menu'].append(item)

    return render(request, 'home.html', {
        'page_title': 'Welcome home!',
        'page_header': 'Good to seeing you',
        'template': 'testing',
        'content': {   
            'out': output,
        },
    })
    return output