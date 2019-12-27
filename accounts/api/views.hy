(import [rest_auth.views [LoginView]])
(import [rest_auth.registration.views [RegisterView]])
(import [.serializers [CustomRegisterSerializer]])

(defclass CustomLoginView [LoginView]
  )

(defclass CustomRegisterView [RegisterView]
  [serializer_class CustomRegisterSerializer])
