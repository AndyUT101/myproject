# -*- coding: utf-8 -*-
# Generated by Django 1.9.3 on 2016-03-14 12:31
from __future__ import unicode_literals

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('timetable', '0005_auto_20160314_1223'),
    ]

    operations = [
        migrations.AlterField(
            model_name='time_meta',
            name='time_obj',
            field=models.DateTimeField(default=datetime.datetime(2016, 3, 14, 12, 31, 4, 838868), unique=True),
        ),
    ]