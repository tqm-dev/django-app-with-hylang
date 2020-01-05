(import [django.contrib [admin]]
        [django.contrib.auth.admin [UserAdmin]]
        [.forms [CustomUserCreationForm CustomUserChangeForm]]
        [.models [CustomUser]])

(defclass CustomUserAdmin [UserAdmin]
  [add_form CustomUserCreationForm
   form CustomUserChangeForm
   model CustomUser
   list_display (, "first_name" "last_name" "email" "is_staff" "is_active")
   list_filter (, "first_name" "last_name" "email" "is_staff" "is_active")
   fieldsets (, (, None {"fields" (, "email" "password")})
                (, "Personal information" {"fields" (, "first_name" "last_name")})
                (, "Permissions" {"fields" (, "is_staff" "is_active")}))
   add_fieldsets (, (, None 
                       {"classes" (, "wide")
                        "fields" (, "email" "password1" "password2" "is_staff" "is_active")}))
   search_fields (, "first_name" "last_name" "email")
   ordering (, "first_name" "last_name" "email")])

(.register admin.site CustomUser CustomUserAdmin)
