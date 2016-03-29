from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from .models import Schoolinfo, Sitemap
from user.models import User

from .utils import Site_option
from user.utils import user_alreadyloggedin, get_userrole, review_permission

# Create your views here.

def site_overview(request):
    page_title = 'Site management'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not review_permission(User.objects.get(username = request.session['user']), 'allow:site_edit'):
        return HttpResponseRedirect(reverse('index_home'))

    site_option = Site_option()

    return render(request, 'home.html', {
        'page_header': page_title,
        'template': 'list', # operation, list,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'content': {
            'list': {
                'checkbox': True,
                'name': 'overview',
                'body': (
                    ({'name': 'SiteNav editor',
                        'url': 'siteinfo:sitemap_view'}),

                    ({'name': 'Classroom management',
                        'url': 'classroom:manage'}),

                    ({'name': 'User management',
                        'url': 'user'}),

                    ({'name': 'Class management',
                        'url': 'user'}),
                ),
                'foot': (),
            },
        },
    })

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

def sitemap_view(request):
    page_title = 'SiteNav editor'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not review_permission(User.objects.get(username = request.session['user']), 'allow:site_edit'):
        return HttpResponseRedirect(reverse('index_home'))

    sitemap = Sitemap.objects.all()

    return render(request, 'home.html', {
        'page_header': page_title,
        'template': 'list', # operation, list,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'content': {
            'operation': ( 
                ({'title':'Edit site nav', 
                   'url': 'siteinfo:sp_add',
                   'html_class': 'sp_add'}),
            ),
            'list': {
                'checkbox': True,
                'name': 'sitemap',
                'body': sitemap,
                'foot': (),
            },
        },
    })

def sitemap_edit(request, sitemap_id):
    pass

def sitemap_delete(request, sitemap_id):
    pass
