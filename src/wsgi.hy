"""
WSGI config for src project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/2.1/howto/deployment/wsgi/
"""

(import os [django.core.wsgi [get_wsgi_application]])

(.setdefault os.environ "DJANGO_SETTINGS_MODULE" "src.settings")
(setv application (get_wsgi_application))
