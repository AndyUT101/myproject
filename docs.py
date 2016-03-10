# Get user object
get_user_obj = User.objects.get(username='user2').attribute

# Show all classes
all_form_class = Class_code.objects.all()

# Find out a form class
form_6_class = Class_code.objects.filter(class_name__startswith=6)