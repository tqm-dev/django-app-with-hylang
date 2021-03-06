;;; Development settings

(import [.base [*]])

(setv
  SECRET_KEY "f41z(gp#mm7ktjo1bfux-n*0!mlti$9d1@k_sws@&kl*@tfi21"
  DEBUG True
  ALLOWED_HOSTS ["localhost" "127.0.0.1"]
  DATABASES
    {"default"
      {"ENGINE"   "django.db.backends.postgresql"
       "NAME"     "eCommerceDjango"  ; postgres db name
       "USER"     "kamil"
       "PASSWORD" ""
       "HOST"     "localhost"
       "PORT"     ""}}
  EMAIL_BACKEND "django.core.mail.backends.console.EmailBackend"
  STATIC_URL "/static/"
  STATIC_ROOT (.join os.path BASE_DIR "static")
; STATICFILES_DIRS (, (.join os.path BASE_DIR "static"))

;;; Media files
  MEDIA_URL "/media/"
  MEDIA_ROOT (.join os.path BASE_DIR "media"))

