# -*- coding: utf-8 -*-
# Generated by Django 1.9.3 on 2016-03-25 14:29
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0002_auto_20160325_2226'),
    ]

    operations = [
        migrations.RenameField(
            model_name='permission',
            old_name='permission_key',
            new_name='permission',
        ),
    ]