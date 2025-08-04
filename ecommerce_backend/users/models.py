from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    users_phone = models.CharField(max_length=20, blank=True)
    users_verfiycode = models.CharField(max_length=6, blank=True)
    users_approve = models.BooleanField(default=False)
    users_create = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.email  # or self.username
