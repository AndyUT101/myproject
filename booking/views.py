from django.shortcuts import render

from facilities.models import Facilities, Room
from user.models import User

from user.utils import user_alreadyloggedin, get_userrole, review_permission
from siteinfo.views import site_topnav

from datetime import datetime

from .models import Booking
from .forms import BookingForm

def room_booked(request):
    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user = User.objects.get(username = request.session['user'])
    if not review_permission(user, 'view:booking'):
        return HttpResponseRedirect(reverse('index_home'))

    booking_active = Booking.objects.filter(user = user, book_date__gte=datetime.now()).order_by('end_lesson', 'book_date')
    #booking_archive = Booking.objects.filter(user = user, book_date__lt=datetime.now())

    return render(request, 'home.html', {
        'page_title': 'Welcome home!',
        'page_header': 'Good to seeing you, ',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {   
            'name': 'booking',
            'body': booking_active,
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


