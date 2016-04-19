from django.shortcuts import get_object_or_404, render, redirect
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse
from django.utils import timezone
from django.core.exceptions import ObjectDoesNotExist
from django.db.models import Q

from django.contrib.auth.hashers import check_password, make_password

from datetime import datetime
import math

from .models import *
from .models import Class_code
from .forms import *

from inbox.models import Inbox
from classroom.models import Classroom, User_assignment
from siteinfo.views import site_topnav
from user.utils import *
from timetable.utils import *


"""
template = ('home', 'list', 'form', 'detail', 'calender', 'none', 'test', 'notification')
"""

    
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
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'home',
        'content': {   
            'notification': {
                'current_date': current_sysdate,
                'inbox': inbox_count,
                'classroom': classroom_count,
            },
            'block1': {
                'title': 'Calendar',
                'content': generate_calender(),
            },
            'block2': {
                'title': 'Your Classroom',
                'content': User_assignment.objects.filter(user=user.id),
            },
            'block3': {
                'title': 'About You',
                'content': user,
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
    if check_password(login_password, user_object.password):
        if not already_logged:
            session_timeout_minutes = 120
            request.session.set_expiry(session_timeout_minutes * 60)
            request.session['token'] = generate_token()
            request.session['user'] = user_object.username

            # Update last logged time
            user_object.last_logged = timezone.now()
            user_object.save()

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
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
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
            commit_form.password = make_password(request.POST['password'], hasher='bcrypt')
            
            # 5. Apply to database
            commit_form.save()

            # 6. Return success page
            #return HttpResponse('user_added')

            return render(request, 'home.html', {
                'page_title': 'Add user',
                'page_header': 'Add user',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
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
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
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

    # 3. Collect checkbox list
    delete_list = request.POST.getlist('user_action')

    # 4. Prevent for lower right users delete other greater right user
    # (Functional requirement)
    user_level = get_userrole(request.session['user'])['level']

    user_removeobj = User.objects.filter(pk__in=delete_list)
    unavailable_removeobj = User.objects.filter(role__in=Role.objects.filter(level__gte=user_level))

    if len(set(user_removeobj).intersection(set(unavailable_removeobj))) == 0:
        user_removeobj.delete() #success
        return HttpResponse('user removed.')

    else:
        return HttpResponse('fail removed.')
    
def modify_user(request, username=None):

    # 1. Check permission
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))


    # 1. User have right to edit itself, else check for permission key
    rp = review_permission(User.objects.get(username = request.session['user']), 'allow:user_edit')
    if not (username == None or username == request.session['user']):
        if not rp:
            return HttpResponseRedirect(reverse('index_home'))
    else:
        username = request.session['user']

    # 2. Check GET or POST method
    if request.method == 'GET':
        
        # 3. (GET) Check user exist
        try:
            user_obj = User.objects.get(username = username)
        except ObjectDoesNotExist:
            return HttpResponseRedirect(reverse('user:list_user'))

        # 4. (GET) Return userform
        if rp:
            userform = UsermodForm(instance=user_obj)
        else:
            userform = UsersimpleForm(instance=user_obj)

        return render(request, 'home.html', {
            'page_title': 'Modify a user',
            'page_header': 'Modify a user',
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
            'template': 'form',
            'content': {
                'form': userform.as_ul(),
                'submit_url': 'user:modify_user',
                'route_parameter': username,
            },
        })
        

    elif request.method == 'POST':
        
        # 3. Replace original password if request.POST get empty password
        modify_userobj = User.objects.get(username=username)

        perform_hashed = True
        if len(request.POST['password']) == 0:
            request.POST = request.POST.copy()
            request.POST.update ({'password': modify_userobj.password})
            perform_hashed = False

        # 3. (POST) Field check
        if rp:
            userform = UsermodForm(request.POST, instance=modify_userobj)
            redirect_url = 'user:list_user'
            redirect_text = 'user page'
        else:
            userform = UsersimpleForm(request.POST, instance=modify_userobj)
            redirect_url = 'index_home'
            redirect_text = 'home page'

        if userform.is_valid():
            commit_form =  userform.save(commit=False)
            
            # 4. If password is remain unchanged, skip update password
            if (perform_hashed):
                commit_form.password = make_password(request.POST['password'], hasher='bcrypt')

            commit_form.save()

            # 5. Return success page
            return render(request, 'home.html', {
                'page_title': 'Modify user',
                'page_header': 'Modify user',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'User ' + commit_form.username + ' modify successful',
                    'redirect_text': redirect_text,
                    'redirect_url': redirect_url,
                    'auto_redirect': True,
                },
            })

        else:
            # 5. Return userform
            if rp:
                userform = UsermodForm(request.POST)
            else:
                userform = UsersimpleForm(request.POST)
            return render(request, 'home.html', {
                'page_title': 'Modify a user',
                'page_header': 'Modify a user',
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'form',
                'content': {
                    'form': userform.as_ul(),
                    'submit_url': 'user:modify_user',
                    'route_parameter': username,
                },
            })

    else:
        return HttpResponseRedirect(reverse('index'))

def view_user(request, username, specific_usertype=None):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))
    
    user_obj = get_object_or_404(User, username=username)

    return render(request, 'home.html', {
        'page_title': 'Modify a user',
        'page_header': 'Modify a user',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'testing',
        'content': {
            'obj': user_obj,
        },
    })

def list_user(request, specific_usertype=None, classcode=None):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    default_pagevalue = {'page': 1, 'row_count': 50}
    page_get = request.GET.get('page', default_pagevalue['page'])
    row_count_get = request.GET.get('row_count', default_pagevalue['row_count'])

    try:
        page = int(page_get)
        row_count = int(row_count_get)
    except ValueError:
        page = default_pagevalue['page']
        row_count = default_pagevalue['row_count']

    user_object = User.objects.all()
    if not specific_usertype == None:
        pass

    # 1. GET page_number
    # return HttpResponseRedirect(reverse('user:list_user'))

    # 1. Define list page count
    user_count = user_object.count()
    max_page = math.ceil(user_count/row_count)
    if page > max_page and max_page > 0:
        return HttpResponseRedirect(reverse('user:list_user'))

    user_list = user_object[row_count*(page-1):row_count+row_count*(page-1)]
    
    return render(request, 'home.html', {
        'page_title': 'User management',
        'page_header': 'User management',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list', # operation, list, 
        'content': {
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Create user', 
                   'url': 'user:add_user',
                   'html_class': 'create_user'}),

                ({'title':'Modify user', 
                   'url': 'user:modify_user',
                   # 'url_para': '',
                   'html_class': 'modify_user'}),

                ({'title':'Delete user', 
                   'url': 'user:remove_user',
                   'html_class': 'delete'}),

            ),
            'list': {
                'checkbox': True,
                'name': 'user',
                'body': user_list,
                'foot': (),
            },
            'page_nav': { 
                # operation pattern ('title', 'redirect_url(url:name)', 'assign html class name in list')
                'message': '',
                'count': user_count,
                'page': {
                    'current_page': page,
                    'max_page': max_page,
                },
                'filter': {
                    'usertype': 'student',
                }
            },
        },
    })    

def list_class(request, specific_usertype=None, classcode=None):
    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    class_list = Class_code.objects.all().order_by('class_name')
    
    class_list = [{'class_name':i.class_name, 'class_description': i.class_description, 'count': Class_assignment.objects.filter(class_code = i).count()} for i in class_list]


    return render(request, 'home.html', {
        'page_title': 'User management',
        'page_header': 'User management',
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list', # operation, list, 
        'content': {
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Create class', 
                   'url': 'user:create_class',
                   'html_class': 'create_class'}),
            ),
            'list': {
                'checkbox': True,
                'name': 'class',
                'body': class_list,
                'foot': (),
            },
        },
    })

def create_class(request):
    page_title = 'Add class'
    submit_url = 'user:create_class'
    return_url = 'user:list_class'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    form_obj = ClasscodeForm()
    if request.method == 'POST':
        form_obj = ClasscodeForm(request.POST)

        if form_obj.is_valid():
            form_obj = form_obj.save(commit=False)

            form_obj.save()

            return render(request, 'home.html', {
                'page_title': page_title,
                'page_header': page_title,
                'topnav': site_topnav(get_userrole(request.session['user'])['level']),
                'template': 'notification',
                'content': {
                    'notification': 'Class add successful',
                    'redirect_text': 'all class',
                    'redirect_url': return_url,
                    'auto_redirect': True,
                },
            })

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'form',
        'content': {
            'form': form_obj.as_ul(),
            'submit_url': submit_url,
        },
    })

def modify_class(request, class_code):
    # add student
    page_title = 'View class'
    submit_url = 'user:create_class'
    return_url = 'user:list_class'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))
 
    class_obj = Class_code.objects.get(class_name = class_code)
    class_d = Class_assignment.objects.filter(class_code = class_obj).order_by('class_number')

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list',
        'content': {
            'operation': ( 
                # operation pattern ('title', 'url(url:name)', 'url_para' 'assign html class name in list')
                ({'title':'Add member', 
                   'url': 'user:add_classmember',
                   'url_para': class_code,
                   'html_class': 'add_classmember'}),
            ),
            'list': {
                'name': 'class_d',
                'body': class_d,
                'foot': (),
            },
        },
    })

def delete_class(request, class_code):
    page_title = 'Remove assignment'
    return_url = 'user:list_class'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    try:
        class_item = Class_code.objects.get(class_name = class_code)
    except ObjectDoesNotExist:
        return HttpResponseRedirect(reverse(return_url))

    class_item.delete()

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'notification',
        'content': {
            'notification': 'Class delete successful',
            'redirect_text': 'all class',
            'redirect_url': return_url,
            'auto_redirect': True,
        },
    })

def remove_classmember(request, class_code, user_id):
    page_title = 'Remove class member'
    return_url = 'user:modify_class'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    return_para = class_code
    user = User.objects.get(pk = user_id)
    class_data = Class_code.objects.get(class_name = class_code)

    del_item = Class_assignment.objects.get(user = user, class_code= class_data)
    del_item.delete()

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'notification',
        'content': {
            'notification': 'Class member removes successful',
            'redirect_text': 'Class page',
            'redirect_url': return_url,
            'redirect_para': return_para,
            'auto_redirect': True,
        },
    })

def add_classmember(request, class_code):
    page_title = 'Add class member'
    submit_url = 'user:add_classmember'
    return_url = 'user:modify_class'

    if not user_alreadyloggedin(request):
        return HttpResponseRedirect(reverse('index'))

    if request.method == 'POST':

        add_list = request.POST.getlist('user_action')
        user_addlist = User.objects.filter(pk__in=add_list)
        class_item = Class_code.objects.get(class_name=class_code)

        commit_list = []
        for user_item in user_addlist:
            commit_list.append(Class_assignment(user=user_item, class_code=class_item, class_number=0))

        Class_assignment.objects.bulk_create(commit_list);

        #if len(set(user_removeobj).intersection(set(unavailable_removeobj))) == 0:

        return render(request, 'home.html', {
            'page_title': page_title,
            'page_header': page_title,
            'topnav': site_topnav(get_userrole(request.session['user'])['level']),
            'template': 'notification',
            'content': {
                'notification': 'Class member add successful',
                'redirect_url': return_url,
                'redirect_text': 'the current class',
                'redirect_para': class_code,
                'auto_redirect': True,
            },
        })

    role = Q(role=Role.objects.get(name='teacher')) | Q(role=Role.objects.get(name='student'))
    user_inclass = [i.user.pk for i in Class_assignment.objects.all()]
    available_user = User.objects.exclude(pk__in=user_inclass).filter(role)

    return render(request, 'home.html', {
        'page_title': page_title,
        'page_header': page_title,
        'topnav': site_topnav(get_userrole(request.session['user'])['level']),
        'template': 'list', # operation, list, 
        'content': {
            'list': {
                'checkbox': True,
                #'name': 'user',
                'name': 'class_add',
                'body': available_user,
                'foot': {
                    'enable': True,
                    'submit': {
                        'title':'Add users to class', 
                    },
                },
            },
        },
    })