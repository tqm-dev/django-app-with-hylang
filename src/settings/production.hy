; Production settings

(import [.base [*]] django_heroku)

(setv
  SECRET_KEY (.get os.environ "SECRET_KEY" "")
  DEBUG False
  ALLOWED_HOSTS ["https://ecommerce-backend-django.herokuapp.com/"]
; STATIC_URL "/static/"
; STATIC_ROOT (.join os.path BASE_DIR "static")
; MEDIA_URL "/media/"
; MEDIA_ROOT (.join os.path BASE_DIR "media")

  EMAIL_BACKEND "django.core.mail.backends.console.EmailBackend" ; todo: use mailgun
  STRIPE_SECRET_KEY (.get os.environ "STRIPE_SECRET_KEY" "")
  STRIPE_PUBLISHABLE_KEY (.get os.environ "STRIPE_PUBLISHABLE_KEY" "")
  STATICFILES_DIRS [(.join os.path BASE_DIR "static")]
  STATICFILES_STORAGE "src.storage_backends.StaticStorage"
  DEFAULT_FILE_STORAGE "src.storage_backends.MediaStorage"
  AWS_ACCESS_KEY_ID (.get os.environ "AWS_ACCESS_KEY_ID" "")
  AWS_SECRET_ACCESS_KEY (.get os.environ "AWS_SECRET_ACCESS_KEY" "")
  AWS_STORAGE_BUCKET_NAME (.get os.environ "AWS_STORAGE_BUCKET_NAME" "")
  AWS_S3_CUSTOM_DOMAIN (% "%s.s3.amazonaws.com" AWS_STORAGE_BUCKET_NAME)
  AWS_S3_OBJECT_PARAMETERS {"CacheControl" "max-age=86400"}
  AWS_PRELOAD_METADATA True
  STATIC_URL (% "https://%s/%s/" AWS_S3_CUSTOM_DOMAIN "static")
  ADMIN_MEDIA_PREFIX (% "https://%s/%s/admin/" AWS_S3_CUSTOM_DOMAIN "static")
  MEDIA_URL (% "https://%s/%s/" AWS_S3_CUSTOM_DOMAIN "media"))

(+= INSTALLED_APPS ["storages"])

;;; Activate Django-Heroku.
(.settings django_heroku (locals))

