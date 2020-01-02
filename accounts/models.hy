(import [django.contrib.auth.base_user [BaseUserManager]])
(import [django.contrib.auth.models [AbstractUser]])
(import [django.db [models]])

(defclass CustomUserManager [BaseUserManager]
  "Custom user model manager with email as the unique identifier"
  (defn create_user [self first_name last_name email password &kwargs extra_fields]
    "Create user with the given email and password."
    (if-not email
      (raise (ValueError "The email must be set")))
    (setv
      first_name (.capitalize first_name)
      last_name  (.capitalize last_name)
      email      (.normalize_email self email)
      user       (.model self :first_name first_name :last_name last_name :email email #*extra_fields))
    (.set_password user password)
    (.save user)
    user)

  (defn create_superuser [self first_name last_name email password &kwargs extra_fields]
    "Create superuser with the given email and password."
    (.setdefault extra_fields "is_staff" True)
    (.setdefault extra_fields "is_superuser" True)
    (.setdefault extra_fields "is_active" True)

    (if-not (get extra_fields "is_staff")
      (raise (ValueError "Superuser must have is_staff=True.")))
    (if-not (get extra_fields "is_superuser")
      (raise (ValueError "Superuser must have is_superuser=True.")))
    
    (.create_user self first_name last_name email password #*extra_fields)))

(defclass CustomUser [AbstractUser]
  [username   None
   first_name (.CharField models :max_length 255 :verbose_name "First name")
   last_name  (.CharField models :max_length 255 :verbose_name "Last name")
   email      (.EmailField models :unique True)
   USERNAME_FIELD "email"
   REQUIRED_FIELDS ["first_name" "last_name"]
   objects (CustomUserManager)]

  (defn --str-- [self]
    self.email))
