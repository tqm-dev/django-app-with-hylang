(import [rest_auth.views [LoginView]]
        [rest_auth.registration.views [RegisterView]]
        [.serializers [CustomRegisterSerializer]])

(defclass CustomLoginView [LoginView])

(defclass CustomRegisterView [RegisterView]
  [serializer_class CustomRegisterSerializer])
