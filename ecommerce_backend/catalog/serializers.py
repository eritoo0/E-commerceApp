from rest_framework import serializers
from parler_rest.serializers import TranslatableModelSerializer, TranslatedFieldsField
from .models import Category , Product , ProductImage


# ---------- Category (lite) for nesting ----------
class CategoryLiteSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    image_url = serializers.SerializerMethodField()

    class Meta:
        model = Category
        fields = ["id", "name", "slug", "image", "image_url", "parent", "is_active"]

    def get_name(self, obj):
        return obj.safe_translation_getter("name", any_language=True)

    def get_image_url(self, obj):
        req = self.context.get("request")
        if obj.image and req is not None:
            return req.build_absolute_uri(obj.image.url)
        return None

# ---- tiny helper to build absolute URLs for images ----
def _abs(req, filefield):
    if not filefield:
        return None
    if req is None:
        try:
            return filefield.url
        except Exception:
            return None
    return req.build_absolute_uri(filefield.url)

# ---------- Product Image ----------
class ProductImageSerializer(serializers.ModelSerializer):
    image_url = serializers.SerializerMethodField()

    class Meta:
        model = ProductImage
        fields = ["id", "image", "image_url", "alt"]

    def get_image_url(self, obj):
        return _abs(self.context.get("request"), obj.image)


# ---------- Product (Lite / list) ----------
class ProductLiteSerializer(serializers.ModelSerializer):
    name = serializers.SerializerMethodField()
    short_description = serializers.SerializerMethodField()
    thumbnail_url = serializers.SerializerMethodField()
    category = serializers.PrimaryKeyRelatedField(read_only=True)
    category_name = serializers.SerializerMethodField()
    discount_percent = serializers.IntegerField(read_only=True)
    is_favorite = serializers.SerializerMethodField()
    average_rating = serializers.FloatField(read_only=True)
    rating_count = serializers.IntegerField(read_only=True)

    class Meta:
        model = Product
        fields = [
            "id", "name", "short_description",
            "slug", "price", "old_price", "discount_percent",
            "stock", "thumbnail", "thumbnail_url",
            "category", "category_name",
            "is_active", "created_at",
            "is_favorite", "average_rating", "rating_count",
        ]

    def get_name(self, obj):
        return obj.safe_translation_getter("name", any_language=True)

    def get_short_description(self, obj):
        return obj.safe_translation_getter("short_description", any_language=True)

    def get_thumbnail_url(self, obj):
        return _abs(self.context.get("request"), obj.thumbnail)

    def get_category_name(self, obj):
        if not obj.category_id:
            return None
        return obj.category.safe_translation_getter("name", any_language=True)
    
    def get_is_favorite(self, obj):
        user = self.context["request"].user
        if not user.is_authenticated:
            return False
        return obj.favorited_by.filter(user=user).exists()


# ---------- Product (Detail) with full description + gallery ----------
class ProductDetailSerializer(ProductLiteSerializer):
    description = serializers.SerializerMethodField()
    category_obj = CategoryLiteSerializer(source="category", read_only=True)
    images = ProductImageSerializer(many=True, read_only=True)

    class Meta(ProductLiteSerializer.Meta):
        fields = ProductLiteSerializer.Meta.fields + [
            "description", "category_obj", "images"
        ]

    def get_description(self, obj):
        return obj.safe_translation_getter("description", any_language=True)
