# -*- coding: utf-8 -*-
# Generated by Django 1.9.3 on 2016-03-15 02:36
from __future__ import unicode_literals

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0008_auto_20160315_0932'),
    ]

    operations = [
        migrations.AlterField(
            model_name='session',
            name='timeout',
            field=models.DateTimeField(default=datetime.datetime(2016, 3, 15, 7, 36, 58, 510996, tzinfo=utc)),
        ),
    ]