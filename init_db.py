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

for i in range(1, 20):
    j = str(i)
    if len(j) == 1:
        j = str(0)*2 + j
    if len(j) == 2:
        j = str(0) + j
    fn = f[random.randrange(0, len(f))]
    xx = l[random.randrange(0, len(l))]
    yy = x[random.randrange(0, len(x))]
    ln =  xx+ ' ' + yy
    username = 'teacher_'+fn[0]+xx[0]+yy[0]
    ph = make_password(username, hasher='bcrypt')
    card_id = ''
    strn_code = ''
    sams_code = ''
    birth_date = date(random.randint(1995, 2007), random.randint(1, 12), random.randint(1, 30))
    hkid_card = 'Y'+str(random.randint(1000, 9999))+str(random.randint(1000, 9999))
    phone = int(str(random.randint(1000, 9999))+str(random.randint(1000, 9999)))
    email = username + '@hgcollege.hk'
    z = User(card_id = card_id, strn_code = strn_code, sams_code = sams_code, username = username, firstname = fn, lastname = ln, password = ph, role = rr, birth_date = birth_date, hkid_card = hkid_card, phone = phone, email = email)
    op.append(z)

done = User.objects.bulk_create(op)
