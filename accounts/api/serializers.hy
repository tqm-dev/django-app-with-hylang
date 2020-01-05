(import [django.contrib.auth [get_user_model]]
        [rest_framework [serializers]]
        [rest_auth.serializers [LoginSerializer]])

(try
  (import [allauth.utils [email_address_exists]])
  (import [allauth.account.adapter [get_adapter]])
  (import [allauth.account.utils [setup_user_email]])
  (except [ImportError]
    (raise (ImportError "allauth needs to be added to INSTALLED_APPS."))))

(setv User (get_user_model))

(defclass CustomUserDetailsSerializer [serializers.ModelSerializer]
  (defclass Meta []
    [model  User
     fields (, "id" "first_name" "last_name" "email")]))

(defclass CustomLoginSerializer [LoginSerializer]
  [username None
   email    (.EmailField serializers :required False :allow_blank True)
   password (.CharField serializers :style {"input_type" "password"})])

(defclass CustomRegisterSerializer [serializers.Serializer]
  "Modified RegisterSerializer class from rest_auth"
  [username   None
   first_name (.CharField serializers :required True)
   last_name  (.CharField serializers :required True)
   email      (.EmailField serializers :required True)
   password1  (.CharField serializers :write_only True :style {"input_type" "password"})
   password2  (.CharField serializers :write_only True :style {"input_type" "password"})]

  (defn validate_email [self email]
    (setv email (-> (get_adapter) (.clean_email email)))
    (if (and email (email_address_exists email))
      (raise (.ValidationError serializers
               "A user is already registered with this e-mail address.")))
    email)

  (defn validate_password1 [self password]
    (-> (get_adapter) (.clean_password password)))

  (defn validate [self data]
    (if (!= (get data "password1") (get data "password2"))
      (raise (.ValidationError serializers 
               "The two password fields didn't match.")))
    data)

  (defn get_cleaned_data [self]
    {"first_name" (get self.validated_data "first_name")
     "last_name"  (get self.validated_data "last_name")
     "password1"  (get self.validated_data "password1")
     "email"      (get self.validated_data "email")})

  (defn save [self request]
    (setv adapter (get_adapter))
    (setv user (.new_user adapter request))
    (setv self.cleaned_data (self.get_cleaned_data))
    (.save_user adapter request user self)
    (setup_user_email request user [])
    user))
