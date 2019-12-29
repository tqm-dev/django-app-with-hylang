(import [django.test [TestCase]]
        [products.models [Category Product]]
        [products.api.serializers [CategorySerializer ProductSerializer]])

(defclass ProductsModelTest [TestCase]
  (defn setUp [self]
    (setv self.test_product (.create Product.objects 
                              :name "Test Product" 
                              :slug "test-product" 
                              :price "9.99"))
    (.save self.test_product)
    (.create self.test_product.category :name "Test Category"))

  (defn test_category_string_representation [self]
    (setv test_category (.get Category.objects :name "Test Category"))
    (.assertEqual self (str test_category) "Test Category"))

  (defn test_product_string_representation [self]
    (setv test_product (.get Product.objects :name "Test Product"))
    (.assertEqual self (str test_product) "Test Product"))

  (defn test_is_featured [self]
    (setv test_product (.get Product.objects :name "Test Product"))
    (.assertFalse self test_product.is_featured))

  (defn test_is_available [self]
    (setv test_product (.get Product.objects :name "Test Product"))
    (.assertTrue self test_product.is_available))

  (defn test_product_with_too_long_name [self]
    (import random string)
    (import [django.db.utils [DataError]])
    (setv long_name (.join "" (lfor n (range 151) (.choice random string.ascii_lowercase))))
    (with [(.assertRaises self DataError)]
      (.create Product.objects :name long_name :slug "long-name")))

  (defn test_product_with_too_long_slug [self]
    (import random 
            string
            [django.db.utils [DataError]])
    (setv long_slug (.join "" (lfor n (range 201) (.choice random string.ascii_lowercase))))
    (with [(.assertRaises self DataError)]
      (.create Product.objects :name "Long slug" :slug long_slug))))

(defclass ProductsAPISerializersTest [TestCase]
  (defn test_product_category_valid [self]
    """Test if serializer works as expected"""
    (setv serializer (CategorySerializer :data {"id" 1 "name" "Test Category"}))
    (.assertTrue self (.is_valid serializer))
    (.assertEqual self serializer.validated_data {"id": 1, "name": "Test Category"})
    (.assertEqual self serializer.errors {}))

  (defn test_product_category_invalid [self]
    """Test if serializer 'breaks' with incomplete data"""
    (setv serializer (CategorySerializer :data {"name" "Test Category Incomplete"}))
    (.assertFalse self (.is_valid serializer))
    (.assertNotEqual self serializer.errors {})))


(defclass ProductAPIViewsTest [TestCase])
