# -*- coding: utf-8 -*-
# Generated by Django 1.9.3 on 2016-03-16 12:25
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Schoolinfo',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('infokey', models.CharField(default='', max_length=255, unique=True)),
                ('infoval', models.CharField(default='', max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='Sitemap',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(default='', max_length=255)),
                ('level', models.PositiveSmallIntegerField(default=1)),
                ('url_route', models.CharField(default='', max_length=255)),
            ],
        ),
    ]