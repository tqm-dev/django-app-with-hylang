(import [django.db [models]])

; Create your models here.
(defclass Subscriber [models.Model]
  [email (.EmailField models :unique True)
   joined_date (.DateTimeField models :auto_now_add True)]

  (defclass Meta []
    [verbose_name "Subscriber"
     verbose_name_plural "Subscribers"])

  (defn --str-- [self]
    self.email))
