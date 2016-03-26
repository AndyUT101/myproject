"""
Initial database setting for Django Shell

"""

# Class code init

# Permission meta init

# Calendar name init

# Fake user generator

# create dummy account

from django.contrib.auth.hashers import check_password, make_password
from user.models import User, Role
import random

f = ('Lee', 'Kong', 'Chan', 'Mak', 'Cheung', 'Fung', 'Tang', 'Wong', 'Tai', 'Ho')
l = ('Yee', 'Yu Ka', 'Ka Wing', 'Sai To', 'Wing On', 'Mei Fung', 'Fung Kung', 'Siu Ming', 'Wing Lam', 'Ka Wai')
rr = Role.objects.get(name="student")
op = []

for i in range(41, 120):
    j = str(i)
    if len(j) == 1:
        j = str(0)*2 + j
    if len(j) == 2:
        j = str(0) + j
    username = 's1501'+ j
    fn = f[random.randint(0,9)]
    ln = l[random.randint(0,9)]
    ph = make_password(username, hasher='bcrypt')
    z = User(username = username, firstname = fn, lastname = ln, password_hash = ph, role = rr)
    op.append(z)

done = User.objects.bulk_create(op)
