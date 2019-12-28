(import [django.contrib.auth.forms [UserCreationForm UserChangeForm]])
(import [.models [CustomUser]])

(defclass CustomUserCreationForm [UserCreationForm]
  (defclass Meta [UserCreationForm]
    [model CustomUser
     fields (, "first_name" "last_name" "email")]))

(defclass CustomUserChangeForm [UserChangeForm]
  (defclass Meta []
    [model CustomUser
     fields (, "first_name" "last_name" "email")]))
