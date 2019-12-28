(import [rest_framework [permissions]])

(defclass IsPostOrIsAdmin [permissions.BasePermission]
  (defn has_permission [self request view]
    (if (= request.method "POST")
     True                                       ; allow all POST requests
     (and request.user request.user.is_staff)))); Otherwise, only allow authenticated requests
    
