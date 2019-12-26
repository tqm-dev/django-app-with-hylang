(import [rest_framework [viewsets]])
(import [rest_framework.filters  [SearchFilter OrderingFilter]])
(import [.serializers [ProductSerializer CategorySerializer]])
(import [products.models [Product Category]])


(defclass CategoryViewSet [viewsets.ModelViewSet]
    [queryset (.objects.all Category)
     serializer_class (CategorySerializer)])


(defclass ProductViewSet [viewsets.ModelViewSet]
    [queryset (.objects.all Product)
     ;permission_classes permissions.IsAuthenticated
     serializer_class ProductSerializer
     lookup_field "slug"
     filter_backends [SearchFilter OrderingFilter]
     search_fields ["category__name" "name" "description"]])
