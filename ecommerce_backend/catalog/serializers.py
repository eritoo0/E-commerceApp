from rest_framework import serializers
from .models import Category

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
