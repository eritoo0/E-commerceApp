from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.utils.translation import gettext_lazy as _
from .models import CustomUser

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    readonly_fields = ("users_create", "last_login", "date_joined")
    fieldsets = (
        (None, {"fields": ("email", "password")}),
        (_("Personal info"), {"fields": ("username",)}),
        (_("Permissions"), {"fields": ("is_active","is_staff","is_superuser","groups","user_permissions")}),
        (_("Important dates"), {"fields": ("last_login","date_joined")}),
        (_("Extras"), {"fields": ("users_phone","users_verfiycode","users_approve","users_create")}),
    )
    add_fieldsets = (
        (None, {"classes": ("wide",), "fields": ("email", "password1", "password2")}),
    )
    list_display = ("id","email","username","users_phone","is_active","is_staff","users_approve")
    search_fields = ("email","username","users_phone")
    ordering = ("email",)
