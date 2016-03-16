from django.contrib import admin

from .models import *

admin.site.register(Classroom)
admin.site.register(Announce)
admin.site.register(Assignment)
admin.site.register(User_assignment)
admin.site.register(Assignment_pool)
admin.site.register(Note)
admin.site.register(Classroom_note)
admin.site.register(Material_type)
admin.site.register(Material_ext)
admin.site.register(Material)