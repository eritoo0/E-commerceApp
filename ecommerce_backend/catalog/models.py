# catalog/models.py
from django.db import models
from django.utils.text import slugify
from parler.models import TranslatableModel, TranslatedFields

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
