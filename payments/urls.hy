(import [django.urls [path]]
        [.views [charge_view]])

(setv urlpatterns [(path "" charge_view :name "charge_view")])

