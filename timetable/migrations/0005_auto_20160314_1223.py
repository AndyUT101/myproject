# -*- coding: utf-8 -*-
# Generated by Django 1.9.3 on 2016-03-14 04:23
from __future__ import unicode_literals

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('timetable', '0004_auto_20160314_1222'),
    ]

    operations = [
        migrations.AlterField(
            model_name='time_meta',
            name='time_obj',
            field=models.DateTimeField(default=datetime.datetime(2016, 3, 14, 12, 23, 40, 861099), unique=True),
        ),
    ]
