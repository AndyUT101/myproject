from django.db import models

class Room(models.Model):
    FLOOR_CHOICES = (
        ('G', 'G/F'),
        ('1', '1/F'),
        ('2', '2/F'),
        ('3', '3/F'),
        ('4', '4/F'),
        ('5', '5/F'),
        ('6', '6/F'),
        ('7', '7/F'),
        ('8', '8/F'),
    )

    plate_name = models.CharField(max_length=6, default="")
    floor = models.CharField(max_length = 1, choices = FLOOR_CHOICES, default = 'G')
    description = models.CharField(max_length=255, default="")
    available = models.BooleanField(default=True)

    def __str__(self):
        return self.plate_name

class Facilities(models.Model):
    name = models.CharField(max_length=255, default="")
    room = models.OneToOneField(Room, on_delete=models.CASCADE)

    def __str__(self):
        return self.name