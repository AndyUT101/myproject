from django.contrib import admin

from .models import *

admin.site.register(Time_meta)
admin.site.register(Event_terms)
admin.site.register(Activity_event)

admin.site.register(Calendar)
admin.site.register(Timetable)

