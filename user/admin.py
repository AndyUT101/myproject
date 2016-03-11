from django.contrib import admin

from .models import *

admin.site.register(User)
admin.site.register(Role)

admin.site.register(Permission_meta)
admin.site.register(Permission)
admin.site.register(Session)
admin.site.register(Parent_contact)


admin.site.register(Class_code)
admin.site.register(Class_assignment)
