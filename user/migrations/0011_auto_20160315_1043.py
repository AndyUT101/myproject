# -*- coding: utf-8 -*-
# Generated by Django 1.9.3 on 2016-03-15 02:43
from __future__ import unicode_literals

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0010_auto_20160315_1038'),
    ]

    operations = [
        migrations.AlterField(
            model_name='session',
            name='timeout',
            field=models.DateTimeField(default=datetime.datetime(2016, 3, 15, 7, 43, 46, 111845, tzinfo=utc)),
        ),
    ]
