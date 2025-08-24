from rest_framework import viewsets, filters
from rest_framework.pagination import PageNumberPagination
from django_filters.rest_framework import DjangoFilterBackend
from django.utils import translation
from .models import Category, Product
from .serializers import CategoryLiteSerializer, ProductLiteSerializer  , ProductDetailSerializer

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

class SmallPagination(PageNumberPagination):
    page_size = 12
    page_size_query_param = "page_size"
    max_page_size = 60


class ProductViewSet(viewsets.ReadOnlyModelViewSet):
    """
    List => ProductLiteSerializer (fast)
    Retrieve => ProductDetailSerializer (with gallery & long description)
    Language: ?lang=en|fr|ar overrides active language for this request.
    """
    queryset = (Product.objects
                .filter(is_active=True)
                .select_related("category"))
    serializer_class = ProductLiteSerializer
    pagination_class = SmallPagination
    filter_backends = [filters.SearchFilter, filters.OrderingFilter, DjangoFilterBackend]
    search_fields = [
        "translations__name",
        "translations__short_description",
        "translations__description",
    ]
    ordering_fields = ["price", "created_at"]
    filterset_fields = {
        "category": ["exact"],
        "category__parent": ["exact"],
        "is_active": ["exact"],
        "slug": ["exact"],  # allows /api/products/?slug=your-slug
    }

    def initial(self, request, *args, **kwargs):
        super().initial(request, *args, **kwargs)
        lang = request.query_params.get("lang")
        if lang:
            translation.activate(lang)
            request.LANGUAGE_CODE = lang

    def get_queryset(self):
        qs = super().get_queryset()
        # Prefetch gallery only for detail action (retrieve)
        if getattr(self, "action", None) == "retrieve":
            return qs.prefetch_related("images")
        return qs

    def get_serializer_class(self):
        if getattr(self, "action", None) == "retrieve":
            return ProductDetailSerializer
        return ProductLiteSerializer