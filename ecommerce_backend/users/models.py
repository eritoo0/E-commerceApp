from django.contrib.auth.models import AbstractUser
from django.contrib.auth.validators import UnicodeUsernameValidator
from django.utils.translation import gettext_lazy as _
from django.db import models

class CustomUser(AbstractUser):
    # Username becomes OPTIONAL and NOT unique (display name only)
    username_validator = UnicodeUsernameValidator()
    username = models.CharField(
        _("username"),
        max_length=150,
        unique=False,
        blank=True,
        null=True,
        help_text=_("Optional. 150 characters or fewer. Letters, digits and @/./+/-/_ only."),
        validators=[username_validator],
    )

    # Email is the login identifier; must be unique
    email = models.EmailField(_("email address"), unique=True, blank=False, null=False)

    # Optional phone; unique when provided (NULLs don’t collide)
    users_phone = models.CharField(max_length=20, blank=True, null=True, unique=True)

    users_verfiycode = models.CharField(max_length=6, blank=True)
    users_approve = models.BooleanField(default=False)
    users_create = models.DateTimeField(auto_now_add=True)

    # Use email for authentication
    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["username"]

    def save(self, *args, **kwargs):
        # normalize email & avoid empty-string phones
        if self.email:
            self.email = self.email.strip().lower()
        if self.users_phone == "":
            self.users_phone = None
        super().save(*args, **kwargs)

    def __str__(self):
        return self.email or self.username or str(self.pk)
