from rest_framework import viewsets, filters ,status, permissions
from rest_framework.pagination import PageNumberPagination
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from django.utils import translation
from django.db.models import Avg, Count      
from .models import Category, Product, Favorite, ProductRating
from .serializers import CategoryLiteSerializer, ProductLiteSerializer  , ProductDetailSerializer
#from django.db.models import 

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
        qs = qs.annotate(
            average_rating=Avg("ratings__score"),
            rating_count=Count("ratings")
        )
        # Prefetch gallery only for detail action (retrieve)
        if getattr(self, "action", None) == "retrieve":
            return qs.prefetch_related("images")
        return qs

    def get_serializer_class(self):
        if getattr(self, "action", None) == "retrieve":
            return ProductDetailSerializer
        return ProductLiteSerializer
    
    @action(detail=True, methods=["post"],
            permission_classes=[permissions.IsAuthenticated])
    def favorite(self, request, pk=None):
        """Toggle favorite on/off for the current user."""
        product = self.get_object()
        fav, created = Favorite.objects.get_or_create(
            user=request.user, product=product
        )
        if not created:
            fav.delete()
            return Response({"favorited": False})
        return Response({"favorited": True})

    @action(detail=True, methods=["post"],
            permission_classes=[permissions.IsAuthenticated])
    def rate(self, request, pk=None):
        """Create or update a 1–5 star rating."""
        product = self.get_object()
        score = int(request.data.get("score", 0))
        if score < 1 or score > 5:
            return Response({"detail": "Score must be 1–5"},
                            status=status.HTTP_400_BAD_REQUEST)

        rating, _ = ProductRating.objects.update_or_create(
            user=request.user, product=product,
            defaults={"score": score}
        )
        return Response({
            "score": rating.score,
            "average": product.ratings.aggregate(avg=models.Avg("score"))["avg"],
            "count": product.ratings.count(),
        })    
    
