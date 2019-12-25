;;; Base settings for the project

(import os)

(setv BASE_DIR (->> (.abspath os.path __file__) (.dirname os.path) (.dirname os.path)))

(setv INSTALLED_APPS 
  ["django.contrib.admin"
   "django.contrib.auth"
   "django.contrib.contenttypes"
   "django.contrib.sessions"
   "django.contrib.messages"
   "django.contrib.staticfiles"
   "corsheaders"
   "products"
   "taggit"
   "rest_framework"
   "rest_framework.authtoken"
   "rest_auth"
   "django.contrib.sites"
   "allauth"
   "allauth.account"
   "allauth.socialaccount"
   "rest_auth.registration"
   "accounts"
   "payments"
   "newsletter"])

(setv SITE_ID 1)

(setv MIDDLEWARE
  ["corsheaders.middleware.CorsMiddleware"
   "django.middleware.security.SecurityMiddleware"
   "django.contrib.sessions.middleware.SessionMiddleware"
   "django.middleware.common.CommonMiddleware"
   "django.middleware.csrf.CsrfViewMiddleware"
   "django.contrib.auth.middleware.AuthenticationMiddleware"
   "django.contrib.messages.middleware.MessageMiddleware"
   "django.middleware.clickjacking.XFrameOptionsMiddleware"])

(setv ROOT_URLCONF "src.urls")

(setv TEMPLATES
  [{"BACKEND"  "django.template.backends.django.DjangoTemplates"
    "DIRS"     [(.join os.path BASE_DIR "templates")]
    "APP_DIRS" True
    "OPTIONS"  {"context_processors" 
                 ["django.template.context_processors.debug"
                  "django.template.context_processors.request"
                  "django.contrib.auth.context_processors.auth"
                  "django.contrib.messages.context_processors.messages"
                  ; `allauth` needs this from django
                  "django.template.context_processors.request"]}}])

(setv WSGI_APPLICATION "src.wsgi.application")

(setv AUTH_PASSWORD_VALIDATORS
  [{"NAME" "django.contrib.auth.password_validation.UserAttributeSimilarityValidator"}
   {"NAME" "django.contrib.auth.password_validation.MinimumLengthValidator"}
   {"NAME" "django.contrib.auth.password_validation.CommonPasswordValidator"}
   {"NAME" "django.contrib.auth.password_validation.NumericPasswordValidator"}])

(setv LANGUAGE_CODE "en-gb")
(setv TIME_ZONE "Europe/London")
(setv USE_I18N True)
(setv USE_L10N True)
(setv USE_TZ True)

;;; CUSTOM SETTINGS

(setv TAGGIT_CASE_INSENSITIVE True)
(setv CORS_ORIGIN_ALLOW_ALL True)

; authentication related stuff
(setv AUTH_USER_MODEL "accounts.CustomUser")

(setv AUTHENTICATION_BACKENDS
  (,; Needed to login by username in Django admin, regardless of `allauth`
    "django.contrib.auth.backends.ModelBackend"
    ; `allauth` specific authentication methods, such as login by e-mail
    "allauth.account.auth_backends.AuthenticationBackend"))

(setv REST_FRAMEWORK
  {"DEFAULT_PERMISSION_CLASSES" 
      ;"rest_framework.permissions.IsAuthenticated")
    (, "rest_framework.permissions.IsAuthenticatedOrReadOnly") 
   "DEFAULT_AUTHENTICATION_CLASSES" 
     (, "rest_framework_jwt.authentication.JSONWebTokenAuthentication"
        "rest_framework.authentication.SessionAuthentication"
        "rest_framework.authentication.BasicAuthentication")})

(setv ACCOUNT_USER_MODEL_USERNAME_FIELD None)
(setv ACCOUNT_EMAIL_REQUIRED True)
(setv ACCOUNT_USERNAME_REQUIRED False)
(setv ACCOUNT_SIGNUP_PASSWORD_ENTER_TWICE False)
(setv ACCOUNT_SESSION_REMEMBER True)
(setv ACCOUNT_AUTHENTICATION_METHOD "email")
(setv ACCOUNT_UNIQUE_EMAIL True)

(setv REST_AUTH_SERIALIZERS
  {"USER_DETAILS_SERIALIZER" 
    "accounts.api.serializers.CustomUserDetailsSerializer"
   "LOGIN_SERIALIZER" 
    "accounts.api.serializers.CustomLoginSerializer"})

(setv REST_AUTH_REGISTER_SERIALIZERS
  {"REGISTER_SERIALIZER" "accounts.api.serializers.CustomRegisterSerializer"})

(setv REST_USE_JWT True)
