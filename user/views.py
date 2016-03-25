from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound, Http404
from django.core.urlresolvers import reverse

from django.core.exceptions import ObjectDoesNotExist
from django.db.utils import IntegrityError

from django.contrib.auth.hashers import check_password, make_password

from .models import User, Permission, Permission_meta
from inbox.models import Inbox
from classroom.models import Classroom, User_assignment

from .forms import UserForm, UsermodForm

import random, string
from datetime import datetime

"""
template = ('home', 'list', 'form', 'detail', 'none', 'test', 'notification')
"""

def generate_token(length = 8):
    """
    Generate random token for session
    """
    random_string = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(length))

    return make_password(random_string, hasher='md5')[4:]

def review_permission(user, permission):
    has_right = False

    # 1. Check permission key information
    try:
        key = Permission_meta.objects.get(key=permission)
    except ObjectDoesNotExist:
        return has_right

    # 2. Check user right fulfill key requirement
    key_require = key.level
    user_level = User.objects.get(username=user).role.level

    if key_require <= user_level:
        has_right = True
        return has_right

    # 3. Check user have permission key right
    try:
        key = Permission.objects.get(permission=key.pk, user=user.pk)
        has_right = True

    except ObjectDoesNotExist:
        return has_right

    return has_right

def get_userrole(user):
    """
    return: dict({'role': 'str', 'level': 'int'})
    """
    try:
        user_obj = User.objects.get(username=user)

    except ObjectDoesNotExist:
        return None

    return dict({'role': user_obj.role.name, 'level': user_obj.role.level})


def user_alreadyloggedin(request):
    status = False
    if 'token' in request.session and 'user' in request.session:
        status = True

    return status
    
def index(request):
    if 'token' in request.session and 'user' in request.session:
        return HttpResponseRedirect(reverse('index_home'))

    if request.GET.get('logout', ''):
        error_message = 'Logout successful, goodbye!'
    else:
        error_message = 'Please log-in before using SchoolPro system.'

    return render(request, 'login.html', {'error_message': error_message})

def index_home(request):
    if not ('token' in request.session and 'user' in request.session):
        return HttpResponseRedirect(reverse('index')+'?login_first')
    
    user = User.objects.get(username = request.session['user'])
    current_sysdate = datetime.now().strftime("%B %d, %Y")

    # inbox count
    inbox_count = Inbox.objects.filter(read=False, receiver=user.id).count()

    # classroom count
    classroom_count = User_assignment.objects.filter(user=user.id).count()

    return render(request, 'home.html', {
        'page_title': 'Welcome home!',
        'page_header': 'Good to seeing you, ' + user.lastname,
        'template': 'home',
        'content': {   
            'notification': {
                'current_date': current_sysdate,
                'inbox': inbox_count,
                'classroom': classroom_count,
            },
        },
    })

def login(request):
    redirect_page = 'index'

    # Review login session status
    already_logged = False
    if 'token' in request.session and 'user' in request.session:
        already_logged = True

        # Break process, return to index page
        return HttpResponseRedirect(reverse('index_home'))

    # Login authentication
    login_account = request.POST.get('account', '')
    login_password = request.POST.get('password', '')

    if not (login_account and login_password):
        ## Skip database process, return index page
        return render(request, 'login.html', {
            'error_message': "Login failed: Empty username or password!",
        })
        
    ## Access database for user data
    try:
        user_object = User.objects.get(username = login_account)

    except ObjectDoesNotExist:
        return render(request, 'login.html', {
            'error_message': "Login failed: No such user!",
        })

    ## Check password hash, assign session for logged user
    if check_password(login_password, user_object.password_hash):
        if not already_logged:
            session_timeout_minutes = 120
            request.session.set_expiry(session_timeout_minutes * 60)
            request.session['token'] = generate_token()
            request.session['user'] = user_object.username

        # Redirect to page
        # return render(request, 'login.html', {
        #    'error_message': "Successful logged.",
        # })
        return HttpResponseRedirect(reverse('index_home'))

    return render(request, 'login.html', {
           'error_message': "Looks like these are not your correct details. Please try again.",
        })

def logout(request):
    """
    Logout user account, remove token and user session
    """

    logout_progress = False
    if 'token' in request.session:
        del request.session['token']
        logout_progress = True
    if 'user' in request.session:
        del request.session['user']
        logout_progress = True

    # Logout success, return index page
    if logout_progress:
        return HttpResponseRedirect(reverse('index')+'?logout=True')

    return HttpResponseRedirect(reverse('index'))

def add_user(request):
    
    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not review_permission(User.objects.get(username = request.session['user']), 'allow:user_add'):
        return HttpResponseRedirect(reverse('index_home'))

    # 2. Check GET or POST method
    if request.method == 'GET':
        
        # 3. (GET) Generate model form object
        return render(request, 'home.html', {
            'page_title': 'Add user',
            'page_header': 'Add user',
            'template': 'form',
            'content': {
                'form': UserForm().as_ul(),
                'submit_url': 'user:add_user',
            },
        })

    elif request.method == 'POST':
        
        # 3. (POST) Field check
        user_form = UserForm(request.POST)
        if user_form.is_valid():
            commit_form =  user_form.save(commit=False)
            
            # 4. Hash the password object
            commit_form.password_hash = make_password(request.POST['password_hash'], hasher='bcrypt')
            
            # 5. Apply to database
            commit_form.save()

            # 6. Return success page
            #return HttpResponse('user_added')

            return render(request, 'home.html', {
                'page_title': 'Add user',
                'page_header': 'Add user',
                'template': 'notification',
                'content': {
                    'notification': 'User ' + commit_form.username + 'add successful',
                    'redirect_text': 'user page',
                    'redirect_url': 'user:add_user',
                    'auto_redirect': True,
                },
            })

        else:
            # 6. Return user page with posted data
            return render(request, 'home.html', {
                'page_title': 'Add user',
                'page_header': 'Add user',
                'template': 'form',
                'content': {
                    'form': UserForm(request.POST).as_ul(),
                    'submit_url': 'user:add_user',
                },
            })

    else:
        return HttpResponseRedirect(reverse('index')) 

def remove_user(request):

    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not review_permission(User.objects.get(username = request.session['user']), 'allow:user_delete'):
        return HttpResponseRedirect(reverse('index_home'))

    # 2. Check delete confirmation
    if not request.POST.get('remove_confirm', ''):
        return HttpResponseRedirect(reverse('index_home'))

    # 3. Collect checkbox list
    delete_list = request.POST.getlist('msg_action')

    # 4. Prevent for lower right users delete other greater right user
    # (Functional requirement)
    user_level = get_userrole(request.session['user'])['level']

    user_removeobj = User.objects.filter(pk__in=delete_list)
    unavailable_removeobj = User.objects.filter(role__in=Role.objects.filter(level__lte=user_level))

    if len(set(user_removeobj).intersection(set(unavailable_removeobj))) == 0:
        user_removeobj.delete() #success
        return HttpResponse('user removed.')

    else:
        pass # fail
        return HttpResponse('fail removed.')
    
def modify_user(request, username=None):

    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if not review_permission(User.objects.get(username = request.session['user']), 'allow:user_edit'):
        return HttpResponseRedirect(reverse('index_home'))

    # 2. Check GET or POST method
    if request.method == 'GET':
        
        # 3. (GET) Check user exist
        try:
            user_obj = User.objects.get(username = username)
        except ObjectDoesNotExist:
            return HttpResponseRedirect(reverse('user:list_user'))

        # 4. (GET) Return userform
        return render(request, 'home.html', {
            'page_title': 'Modify a user',
            'page_header': 'Modify a user',
            'template': 'form',
            'content': {
                'form': UsermodForm(instance=user_obj).as_ul(),
                'submit_url': 'user:modify_user',
                'route_parameter': username,
            },
        })
        

    elif request.method == 'POST':
        
        # 3. (POST) Field check
        user_form = UsermodForm(request.POST)
        if user_form.is_valid():
            commit_form =  user_form.save(commit=False)
            
            # 4. If password is empty, skip update password
            if (len(commit_form.password) == 0):
                delattr(commit_form, 'password_hash')
            else:
                commit_form.password_hash = make_password(request.POST['password_hash'], hasher='bcrypt')

            User.objects.get(username=username).update(request.POST)

            # 5. Return success page
            return render(request, 'home.html', {
                'page_title': 'Modify user',
                'page_header': 'Modify user',
                'template': 'notification',
                'content': {
                    'notification': 'User ' + commit_form.username + ' modify successful',
                    'redirect_text': 'user page',
                    'redirect_url': 'user:add_user',
                    'auto_redirect': True,
                },
            })

        else:
            # 5. Return userform
            return render(request, 'home.html', {
                'page_title': 'Modify a user',
                'page_header': 'Modify a user',
                'template': 'form',
                'content': {
                    'form': UsermodForm(instance=user_obj).as_ul(),
                    'submit_url': 'user:modify_user',
                    'route_parameter': username,
                },
            })

    else:
        return HttpResponseRedirect(reverse('index'))



"""
def modifyuser_view(request, user_id):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    user_object = get_object_or_404(User, pk = user_id)

    return render(request, 'home.html', {
        'page_title': 'Modify a user',
        'page_header': 'Modify a user',
        'template': 'form',
        'content': {
            'form': UserForm(instance=user_object).as_ul(),
            'submit_url': 'user:modify_user',
        },
    })


def modify_user(request, user_id):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if request.method == 'POST':
        user_form = UserForm(request.POST)

        # Form checking
        if user_form.is_valid():
            user_form.save(commit=False)
            user_form.password_hash = make_password(user_form.password_hash, hasher='bcrypt')
            try:
                # form.save(commit=False) # if any content need to correct
                user = get_object_or_404(User, pk=user_id)
                user_form = UserForm(request.POST, instance = user)
                user_form.save()

            except IntegrityError:
                pass

            return HttpResponse('user_edited')
            
        return render(request, 'home.html', {
            'page_title': 'Modify a user',
            'page_header': 'Modify a user',
            'template': 'form',
            'content': {
                'form': user_form.as_ul(),
                'submit_url': 'user:modify_user',
            },
        })


    return HttpResponseRedirect(reverse('index_home'))
    return HttpResponse(user_id)
"""

def view_user(request, user, specific_usertype=None):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))
    pass

def list_user(request, page=1, row_count=50, specific_usertype=None, classcode=None):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))


    user_list = User.objects.all()[row_count*(page-1):row_count]
    
    return render(request, 'home.html', {
        'page_header': 'Inbox',
        'template': 'list', # operation, list, 
        'content': {
            'operation': ( 
                # operation pattern ('title', 'redirect_url(url:name)', 'assign html class name in list')
                ('Compose', 'inbox:compose', 'compose'),
                ('Delete', 'user:remove_user', 'delete'),

            ),
            'list': {
                'checkbox': True,
                'name': 'user',
                'body': user_list,
                'foot': (),
            },
            'adv_operation': ( 
                # operation pattern ('title', 'redirect_url(url:name)', 'assign html class name in list')
                ('Compose', 'inbox:compose', ['compose']),
                ('Delete', 'inbox:delete', ['delete']),

            ),
        },
    })

    # case 1: list all user
    # case 2: list specific_usertype
    # case 3: filter class_code
    # case 4: search mode (GET + POST data)
