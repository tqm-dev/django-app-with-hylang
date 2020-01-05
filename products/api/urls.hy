(import [django.urls  [path include]]
        [rest_framework.routers [DefaultRouter]]
        [products.api.views [ProductViewSet]])

(setv router (DefaultRouter))
(.register router "" ProductViewSet)
(setv urlpatterns [(path "" (include router.urls))])
