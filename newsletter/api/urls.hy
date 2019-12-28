(import [django.urls [path include]])
(import [newsletter.api.views [Subscribers]])

(setv urlpatterns [(path "" (.as_view Subscribers) :name "list_subscribers")])
