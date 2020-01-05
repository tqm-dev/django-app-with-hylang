(import [django.contrib [admin]]
        [.models [Subscriber]])

; Register your models here.
(defclass SubscriberAdmin [admin.ModelAdmin]
  [list_display (, "email" "joined_date")])

(.register admin.site Subscriber SubscriberAdmin)
