from django.core.exceptions import ObjectDoesNotExist
from django.http import HttpResponse, HttpResponseRedirect, HttpResponseNotFound
from django.core.urlresolvers import reverse


from .models import User, Permission, Permission_meta, Role
from django.contrib.auth.hashers import make_password
import random, string

def user_alreadyloggedin(request):
    status = False
    if 'token' in request.session and 'user' in request.session:
        status = True

    return status

def get_userrole(user):
    """
    return: dict({'role': 'str', 'level': 'int'})
    """
    try:
        user_obj = User.objects.get(username=user)

    except ObjectDoesNotExist:
        return None

    return dict({'role': user_obj.role.name, 'level': user_obj.role.level})

def review_permission(user, permission):
    has_right = False

    # 1. Check permission key information
    try:
        key = Permission_meta.objects.get(key=permission)
    except ObjectDoesNotExist:
        return has_right

    # 2. Check user right fulfill key requirement
    key_require = key.level
    user_level = User.objects.get(pk=user.pk).role.level

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

def generate_token(length = 8):
    """
    Generate random token for session
    """
    random_string = ''.join(random.SystemRandom().choice(string.ascii_uppercase + string.ascii_lowercase + string.digits) for _ in range(length))

    return make_password(random_string, hasher='md5')[4:]