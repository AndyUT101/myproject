from django.shortcuts import render

from facilities.models import Facilities, Room

from user.utils import user_alreadyloggedin, get_userrole
from siteinfo.views import site_topnav

from .forms import BookingForm

# helper function
def room_booked(facilities_obj):
    pass
    # return true false

def book_room(request):

    return render(request, 'home.html', {
        'page_title': 'Add user',
        'page_header': 'Add user',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'form',
        'content': {
            'form': BookingForm().as_ul(),
            'submit_url': 'user:add_user',
        },
    })

