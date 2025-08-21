from rest_framework import viewsets, filters
from django_filters.rest_framework import DjangoFilterBackend
from django.utils import translation
from .models import Category
from .serializers import CategoryLiteSerializer  # <- use Lite

class CategoryViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Category.objects.filter(is_active=True)
    serializer_class = CategoryLiteSerializer
    filter_backends = [filters.SearchFilter, DjangoFilterBackend]
    search_fields = ["translations__name"]
    filterset_fields = {"parent": ["exact", "isnull"]}

   
    def initial(self, request, *args, **kwargs):
        super().initial(request, *args, **kwargs)
        lang = request.query_params.get("lang")
        if lang:
            translation.activate(lang)
            request.LANGUAGE_CODE = lang
