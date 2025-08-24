from django.contrib import admin
from django.utils.html import format_html
from parler.admin import TranslatableAdmin

from .models import Category, Product, ProductImage


# ---------- helpers ----------
def _thumb(imgfield, size=60):
    if not imgfield:
        return "—"
    try:
        return format_html(
            '<img src="{}" style="height:{}px;border-radius:6px;" />',
            imgfield.url, size
        )
    except Exception:
        return "—"


# ---------- Category ----------

@admin.register(Category)
class CategoryAdmin(TranslatableAdmin):
    list_display = ("id", "name_col", "parent", "is_active", "image_thumb")
    list_filter = ("is_active", "parent")
    search_fields = ("translations__name", "slug")
    ordering = ("translations__name",)
    readonly_fields = ("image_thumb", "created_at")

    fieldsets = (
        ("Basics", {
            "fields": ("slug", "parent", "is_active")
        }),
        ("Image", {"fields": ("image", "image_thumb")}),
        ("Dates", {"fields": ("created_at",)}),
        ("Translations", {
            "fields": ["name"]
        }),
    )

    def name_col(self, obj):
        return obj.safe_translation_getter("name", any_language=True)
    name_col.short_description = "Name"

    def image_thumb(self, obj):
        return _thumb(obj.image)
    image_thumb.short_description = "Image"

# ---------- Product images inline (gallery) ----------
class ProductImageInline(admin.TabularInline):
    model = ProductImage
    extra = 1
    fields = ("image", "alt", "preview")
    readonly_fields = ("preview",)

    def preview(self, obj):
        return _thumb(obj.image, size=56)
    preview.short_description = "Preview"


# ---------- Product ----------
@admin.register(Product)
class ProductAdmin(TranslatableAdmin):
    list_display = (
        "id", "name_col", "category", "category_parent",
        "price","old_price" ,"stock", "is_active", "created_at", "image_thumb"
    )
    list_filter = ("is_active", "category")
    search_fields = ("translations__name", "translations__description", "slug", "sku")
    ordering = ("-created_at",)
    inlines = [ProductImageInline]

    readonly_fields = ("image_thumb", "created_at")
    fieldsets = (
        ("Basics", {
            "fields": (
                "slug", "category", "sku",
                "price", "old_price", "stock",
                "is_active"
            )
        }),
        ("Image", {"fields": ("thumbnail", "image_thumb")}),
        ("Dates", {"fields": ("created_at",)}),
        ("Translations", {
            "fields": ("name", "short_description", "description")
        }),
    )

    def name_col(self, obj):
        return obj.safe_translation_getter("name", any_language=True)
    name_col.short_description = "Name"

    def image_thumb(self, obj):
        return _thumb(obj.thumbnail)
    image_thumb.short_description = "Thumbnail"

    def category_parent(self, obj):
        """Show parent category if exists"""
        if obj.category and obj.category.parent:
            return obj.category.parent.safe_translation_getter("name", any_language=True)
        return "—"
    category_parent.short_description = "Parent Category"

# (optional) manage ProductImage separately too
@admin.register(ProductImage)
class ProductImageAdmin(admin.ModelAdmin):
    list_display = ("id", "product", "alt", "preview")
    search_fields = ("product__translations__name", "alt")
    readonly_fields = ("preview",)

    def preview(self, obj):
        return _thumb(obj.image, size=56)
    preview.short_description = "Preview"
