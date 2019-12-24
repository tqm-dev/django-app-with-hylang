#! /usr/bin/env hy
(import os sys hy)

(defmain [&rest argv]
  (os.environ.setdefault "DJANGO_SETTINGS_MODULE" "src.settings")
  (try
    (import [django.core.management [execute_from_command_line]])
    (except [exc ImportError]
      (raise (ImportError
        "Couldn't import Django. Are you sure it's installed and 
        available on your PYTHONPATH environment variable? Did you 
        forget to activate a virtual environment?"))))
  (execute_from_command_line argv))
