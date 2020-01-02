(import [django.conf [settings]]
        [django.http [HttpResponse]]
        [django.views.decorators.csrf [csrf_exempt]]
        [django.views.decorators.http [require_http_methods]])

; Create your views here.
#@((require_http_methods ["POST"]) csrf_exempt
  (defn charge_view [request]
   (print "charge_view is called")))

