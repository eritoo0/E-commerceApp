from rest_framework.routers import DefaultRouter
from .views import CategoryViewSet  

router = DefaultRouter()
router.register(r"categories", CategoryViewSet, basename="category")
router.register(r"products", CategoryViewSet, basename="product")


urlpatterns = router.urls
