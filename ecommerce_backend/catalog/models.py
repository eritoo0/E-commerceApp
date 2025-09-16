from django.db import models
from django.conf import settings
from django.utils.text import slugify
from parler.models import TranslatableModel, TranslatedFields
from decimal import Decimal
from django.core.validators import MinValueValidator , MaxValueValidator


User = settings.AUTH_USER_MODEL

class Category(TranslatableModel):
    translations = TranslatedFields(
        name = models.CharField(max_length=120),
    )

    slug = models.SlugField(max_length=140, unique=True, blank=True)
    image = models.ImageField(upload_to="categories/", blank=True, null=True)
    parent = models.ForeignKey(
        "self", null=True, blank=True, related_name="children", on_delete=models.CASCADE
    )
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Categories"
        ordering = ["translations__name"]  

    def save(self, *args, **kwargs):
        if not self.slug:
            # build slug from any available translation (falls back to any language)
            base = self.safe_translation_getter("name", any_language=True) or "category"
            slug = slugify(base)
            i = 2
            while Category.objects.filter(slug=slug).exists():
                slug = f"{slug}-{i}"
                i += 1
            self.slug = slug
        super().save(*args, **kwargs)

    def __str__(self):
        # show a name in any language to avoid blank __str__
        return self.safe_translation_getter("name", any_language=True) or f"Category {self.pk}"


class Product(TranslatableModel):
    # Translated fields shown to users
    translations = TranslatedFields(
        name=models.CharField(max_length=180),
        short_description=models.CharField(max_length=240, blank=True),
        description=models.TextField(blank=True),
    )

    # Non-translated fields
    slug = models.SlugField(max_length=200, unique=True, blank=True)
    category = models.ForeignKey(
        Category, related_name="products", on_delete=models.PROTECT
    )  # each product belongs to a Category
    price = models.DecimalField(
        max_digits=10, decimal_places=2,
        validators=[MinValueValidator(Decimal("0"))]
    )
    old_price = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    stock = models.PositiveIntegerField(default=0)
    sku = models.CharField(max_length=64, unique=True, blank=True, null=True)  # optional
    thumbnail = models.ImageField(upload_to="products/", blank=True, null=True)
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "Products"
        ordering = ["-created_at"]  # newest first
        indexes = [
            models.Index(fields=["is_active", "category"]),
            models.Index(fields=["slug"]),
        ]

    def save(self, *args, **kwargs):
        # Auto-generate a unique slug from any available translation
        if not self.slug:
            base = self.safe_translation_getter("name", any_language=True) or "product"
            s = slugify(base)
            i = 2
            while Product.objects.filter(slug=s).exists():
                s = f"{s}-{i}"
                i += 1
            self.slug = s
        super().save(*args, **kwargs)

    def __str__(self):
        return self.safe_translation_getter("name", any_language=True) or f"Product {self.pk}"

    @property
    def discount_percent(self) -> int:
        """Convenience property for UI badges like -20%"""
        if self.old_price and self.old_price > 0 and self.price < self.old_price:
            return round(float((self.old_price - self.price) / self.old_price) * 100)
        return 0


class ProductImage(models.Model):
    """Optional gallery images (0..N) for a product."""
    product = models.ForeignKey(Product, related_name="images", on_delete=models.CASCADE)
    image = models.ImageField(upload_to="products/")
    alt = models.CharField(max_length=140, blank=True)

    def __str__(self):
        return f"Image for product {self.product_id}"
    

class Favorite(models.Model):
    """Each row = 1 user likes 1 product."""
    user = models.ForeignKey(User, on_delete=models.CASCADE,
                             related_name="favorites")
    product = models.ForeignKey("Product", on_delete=models.CASCADE,
                                related_name="favorited_by")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ("user", "product")     # user can like only once

    def __str__(self):
        return f"{self.user} ❤ {self.product}"


class ProductRating(models.Model):
    """A 1–5 star rating given by a user to a product."""
    user = models.ForeignKey(User, on_delete=models.CASCADE,
                             related_name="product_ratings")
    product = models.ForeignKey("Product", on_delete=models.CASCADE,
                                related_name="ratings")
    score = models.PositiveSmallIntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(5)]
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        unique_together = ("user", "product")     # one rating per user/product

    def __str__(self):
        return f"{self.product} rated {self.score} by {self.user}"