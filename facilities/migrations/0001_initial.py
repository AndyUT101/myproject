# -*- coding: utf-8 -*-
# Generated by Django 1.9.3 on 2016-03-10 07:39
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Facilities',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(default='', max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='Room',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('plate_name', models.CharField(default='', max_length=6)),
                ('floor', models.CharField(choices=[('G', 'G/F'), ('1', '1/F'), ('2', '2/F'), ('3', '3/F'), ('4', '4/F'), ('5', '5/F'), ('6', '6/F'), ('7', '7/F'), ('8', '8/F')], default='G', max_length=1)),
                ('description', models.CharField(default='', max_length=255)),
                ('available', models.BooleanField(default=True)),
            ],
        ),
        migrations.AddField(
            model_name='facilities',
            name='room',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='facilities.Room'),
        ),
    ]