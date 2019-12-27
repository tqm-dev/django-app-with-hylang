(import [django.contrib [admin]])
(import [.models [Product Category]])

(defclass ProductAdmin [admin.ModelAdmin]
  [list_display  (, "name" "price" "quantity" "featured")
   list_filter   (, "name" "price" "quantity" "featured")
   list_editable (, "price" "quantity")
   ; sets up slug to be generated from product name
   prepopulated_fields {"slug" (, "name")}])

(defclass CategoryAdmin [admin.ModelAdmin]
  [list_display (, "name")
   list_display_links (, "name")])

(.register admin.site Product ProductAdmin)
(.register admin.site Category CategoryAdmin)
