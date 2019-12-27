(import [django.urls [include path]])
(import [.views [CustomRegisterView]])

(setv urlpatterns
 [(path "" (include "rest_auth.urls"))
  (path "register/" (include "rest_auth.registration.urls"))])
