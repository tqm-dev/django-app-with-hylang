;;; Development settings

(import [.base [*]])

(setv SECRET_KEY "f41z(gp#mm7ktjo1bfux-n*0!mlti$9d1@k_sws@&kl*@tfi21")

(setv DEBUG True)

(setv ALLOWED_HOSTS ["localhost" "127.0.0.1"])

(setv DATABASES
  {"default"
    {"ENGINE"   "django.db.backends.postgresql"
     "NAME"     "eCommerceDjango"  ; postgres db name
     "USER"     "kamil"
     "PASSWORD" ""
     "HOST"     "localhost"
     "PORT"     ""}})

(setv EMAIL_BACKEND "django.core.mail.backends.console.EmailBackend")

(setv STATIC_URL "/static/")
(setv STATIC_ROOT (.join os.path BASE_DIR "static"))
; (setv STATICFILES_DIRS (, (.join os.path BASE_DIR "static")))

;;; Media files
(setv MEDIA_URL "/media/"
(setv MEDIA_ROOT (.join os.path BASE_DIR "media"))

(setv STRIPE_SECRET_KEY "YOUR_STRIPE_SECRET_KEY")
(setv STRIPE_PUBLISHABLE_KEY "YOUR_STRIPE_PUBLISHABLE_KEY")
