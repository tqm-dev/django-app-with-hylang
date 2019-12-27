(import [django.db [models]])
(import [django.urls [reverse]])

; tags
(import [taggit.managers [TaggableManager]])

; Create your models here.
(defclass Category [models.Model]
  [name (.CharField models :max_length 100 :unique True)
   ;parent (.ForeignKey models 'self' :on_delete models.CASCADE :null True :blank True)
   ]

  (defclass Meta []
    [verbose_name_plural "Categories"])

  (defn __str__ [self] 
    self.name)

  (defn get_absolute_url [self]
    (reverse "products:category" :kwargs {"name" self.name})))

(defclass Product [models.Model]
  [category     (.ManyToManyField models Category :blank False)
   tags         (TaggableManager :blank True)  ; tags mechanism
   name         (.CharField models :max_length 150)
   slug         (.SlugField models :max_length 200)
   description  (.TextField models :max_length 500 :default "Empty description.")
   picture      (.ImageField models :upload_to "products/images" :null True :blank True)
   price        (.DecimalField models :decimal_places 2 :max_digits 20 :default 0)
   quantity     (.IntegerField models :default 10)  ; available quantity of given product
   featured     (.BooleanField models :default False)] ; is product featured?

  (defclass Meta [] 
    [ordering (, "name")])

  (defn __str__[self] 
    self.name)

  (with-decorator property 
    (defn is_featured [self] self.featured))

  (with-decorator property 
    (defn is_available [self]
     (> self.quantity 0))))

