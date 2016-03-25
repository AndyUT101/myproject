from django.db import models

class Schoolinfo(models.Model):
    infokey = models.CharField(max_length=255, default='', unique=True)
    infoval = models.CharField(max_length=255, default='')

class Sitemap(models.Model):
    title = models.CharField(max_length=255, default='')
    level = models.PositiveSmallIntegerField(default=1)
    url_route = models.CharField(max_length=255, default='')
    top_level = models.ForeignKey('self', on_delete=models.CASCADE, default="")

