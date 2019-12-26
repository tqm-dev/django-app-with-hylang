(import [django.urls  [path include]])
(import [rest_framework.routers [DefaultRouter]])
(import [products.api.views [ProductViewSet]])

(setv router (DefaultRouter))
(.register router "" ProductViewSet)
(setv urlpatterns [(path "" (include router.urls))])
