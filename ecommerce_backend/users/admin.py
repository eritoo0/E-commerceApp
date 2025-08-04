from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    model = CustomUser
    list_display = ("username", "email", "users_phone", "users_approve", "is_staff")

    # ✅ Editable custom fields
    fieldsets = UserAdmin.fieldsets + (
        ("Custom Fields", {
            "fields": ("users_phone", "users_verfiycode", "users_approve")  # ⛔️ remove users_create
        }),
    )

    # ✅ Editable fields when creating a user
    add_fieldsets = UserAdmin.add_fieldsets + (
        ("Custom Fields", {
            "fields": ("users_phone", "users_verfiycode")
        }),
    )
