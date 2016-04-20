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
from datetime import date
import random

f = ('Lee', 'Kong', 'Chan', 'Mak', 'Cheung', 'Fung', 'Tang', 'Wong', 'Tai', 'Ho')
l = ('Yee', 'Yu Ka', 'Ka Wing', 'Sai To', 'Wing On', 'Mei Fung', 'Fung Kung', 'Siu Ming', 'Wing Lam', 'Ka Wai')

l = ('Man', 'Kit', 'Ka ', 'Mei', 'Sai', 'Kit', 'Yu', 'Wai', 'Lun')
x = ('Ling', 'Yu', 'Cheung', 'Yung', 'Ai', 'Mei', 'Wai', 'Ho')
rr = Role.objects.get(name="teacher")
op = []

for i in range(90, 120):
    j = str(i)
    if len(j) == 1:
        j = str(0)*2 + j
    if len(j) == 2:
        j = str(0) + j
    username = 'teacher_' 
    fn = f[random.randint(0,9)]
    ln = l[random.randint(0,9)]
    ph = make_password(username, hasher='bcrypt')
    birth_date = date(random.randint(1995, 2007), random.randint(1, 12), random.randint(1, 30))
    hkid_card = 'Y'+str(random.randint(1000, 9999))+str(random.randint(1000, 9999))
    phone = int(str(random.randint(1000, 9999))+str(random.randint(1000, 9999)))
    email = username + '@hgcollege.hk'
    z = User(username = username, firstname = fn, lastname = ln, password = ph, role = rr, birth_date = birth_date, hkid_card = hkid_card, phone = phone, email = email)
    op.append(z)

done = User.objects.bulk_create(op)
