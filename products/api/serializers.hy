(import [rest_framework [serializers]]
        [products.models [Product Category]])

(defclass CategorySerializer [serializers.ModelSerializer]
  [id (.IntegerField serializers)]

  (defclass Meta []
    [model Category
     fields (, "id" "name")]))

(defclass ProductSerializer [serializers.ModelSerializer]
  (defclass Meta []
    [model Product
     fields (, "id" "name" "price" "quantity" "featured" "description" "picture" "slug")
     lookup_field "slug"]))
