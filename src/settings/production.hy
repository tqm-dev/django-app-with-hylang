# Production settings

(import [.base [*]])

(import django_heroku)

(setv SECRET_KEY (.get os.environ "SECRET_KEY" ""))

(setv DEBUG False)

(setv ALLOWED_HOSTS ["https://ecommerce-backend-django.herokuapp.com/"])

(+= INSTALLED_APPS ["storages"])

; (setv STATIC_URL "/static/")
; (setv STATIC_ROOT (.join os.path BASE_DIR "static"))
; (setv MEDIA_URL "/media/")
; (setv MEDIA_ROOT (.join os.path BASE_DIR "media"))

(setv EMAIL_BACKEND "django.core.mail.backends.console.EmailBackend") # todo: use mailgun

(setv STRIPE_SECRET_KEY (.get os.environ "STRIPE_SECRET_KEY" ""))
(setv STRIPE_PUBLISHABLE_KEY (.get os.environ "STRIPE_PUBLISHABLE_KEY" ""))

(setv STATICFILES_DIRS [(.join os.path BASE_DIR "static")])
(setv STATICFILES_STORAGE "src.storage_backends.StaticStorage")
(setv DEFAULT_FILE_STORAGE "src.storage_backends.MediaStorage")

(setv AWS_ACCESS_KEY_ID (.get os.environ "AWS_ACCESS_KEY_ID" ""))
(setv AWS_SECRET_ACCESS_KEY (.get os.environ "AWS_SECRET_ACCESS_KEY" ""))
(setv AWS_STORAGE_BUCKET_NAME (.get os.environ "AWS_STORAGE_BUCKET_NAME" ""))
(setv AWS_S3_CUSTOM_DOMAIN (% "%s.s3.amazonaws.com" AWS_STORAGE_BUCKET_NAME))
(setv AWS_S3_OBJECT_PARAMETERS {"CacheControl" "max-age=86400"})
(setv AWS_PRELOAD_METADATA True)
(setv STATIC_URL (% "https://%s/%s/" AWS_S3_CUSTOM_DOMAIN "static"))
(setv ADMIN_MEDIA_PREFIX (% "https://%s/%s/admin/" AWS_S3_CUSTOM_DOMAIN "static"))
(setv MEDIA_URL (% "https://%s/%s/" AWS_S3_CUSTOM_DOMAIN "media"))

;;; Activate Django-Heroku.
(.settings django_heroku (locals))
