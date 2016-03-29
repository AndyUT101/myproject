from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist

from facilities.models import Facilities, Room
from user.models import User

from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav

from datetime import datetime

from .models import Booking
from .forms import BookingForm

def room_booked(request):
    page_title = 'My Booking'
    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username = request.session['user'])
    if not review_permission(user, 'view:booking'):
        return HttpResponseRedirect(reverse('index_home'))

    booking_active = Booking.objects.filter(user = user, book_date__gte=datetime.now()).order_by('book_date','start_lesson')
    booking_archive = Booking.objects.filter(user = user, book_date__lt=datetime.now()).order_by('end_lesson', 'book_date')[:5]

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {
            'operation': ( 
                ({'title':'Make booking', 
                   'url': 'booking:reserve',
                   'html_class': 'booking'}),
                ({'title':'View all booking', 
                   'url': 'booking:all',
                   'html_class': 'view_booking'}),
            ),

            'list': {
                'name': 'booking',
                'body': booking_active,
                'body_footer': booking_archive,
            },
        },
    })

def all_booking(request):
    page_title = 'All Booking'

    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username = request.session['user'])
    if not review_permission(user, 'view:booking'):
        return HttpResponseRedirect(reverse('index_home'))

    booking_active = Booking.objects.filter(book_date__gte=datetime.now()).order_by('book_date','start_lesson')
    booking_archive = Booking.objects.filter(book_date__lt=datetime.now()).order_by('end_lesson', 'book_date')[:5]

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {
            'operation': ( 
                ({'title':'Make booking', 
                   'url': 'booking:reserve',
                   'html_class': 'booking'}),
                ({'title':'View my booking', 
                   'url': 'booking:index',
                   'html_class': 'view_booking'}),
            ),
            'list': {
                'name': 'booking_all',
                'body': booking_active,
                'body_footer': booking_archive,
            },
        },
    })

def book_room(request):

    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username = request.session['user'])
    if not review_permission(user, 'allow:booking'):
        return HttpResponseRedirect(reverse('index_home'))

    # 2. Check GET or POST method
    if request.method == 'GET':

        return render(request, 'home.html', {
            'page_title': 'Room Reservation',
            'page_header': 'Reserve for a room',
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
            'template': 'form',
            'content': {
                'form': BookingForm().as_ul(),
                'submit_url': 'booking:reserve',
            },
        })

    elif request.method == 'POST':

        booking_form = BookingForm(request.POST)
        if booking_form.is_valid():
            booking =  booking_form.save(commit=False)

            # Insert User booking content to form
            booking.user = user
            booking.save()

            return render(request, 'home.html', {
                'page_title': 'Room Reservation',
                'page_header': 'Reserve for a room',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Reservation is successful',
                    'redirect_text': 'Booking page',
                    'redirect_url': 'booking:index',
                    'auto_redirect': True,
                },
            })

        else:
            return render(request, 'home.html', {
                'page_title': 'Room Reservation',
                'page_header': 'Reserve for a room',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'form',
                'content': {
                    'form': BookingForm(request.POST).as_ul(),
                    'submit_url': 'booking:reserve',
                },
            })

def remove_book_room(request, booking_id):
    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username = request.session['user'])
    try:
        booking = Booking.objects.get(user=user, pk=booking_id, book_date__gte=datetime.now())
    except ObjectDoesNotExist:
    	return HttpResponseRedirect(reverse('booking:index'))

    booking.delete()

    return render(request, 'home.html', {
        'page_title': 'Remove booking',
        'page_header': 'Remove booking',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'notification',
        'content': {
            'notification': 'Reservation removes successful',
            'redirect_text': 'booking page',
            'redirect_url': 'booking:index',
            'auto_redirect': True,
        },
    })

