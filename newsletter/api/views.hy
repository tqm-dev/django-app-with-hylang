(import [rest_framework [generics status]]
        [rest_framework.response [Response]]
        [newsletter.models [Subscriber]]
        [.serializers [SubscriberSerializer]]
        [.permissions [IsPostOrIsAdmin]])

(defclass Subscribers [generics.ListCreateAPIView]
  "API view for listing all existing subscribers.
   Only safe requests allowed.
   Visible only to users for which user.is_staff returns True."

  [queryset (.all Subscriber.objects)
   serializer_class SubscriberSerializer
   permission_classes (, IsPostOrIsAdmin)])  ; GET for admin, POST for everyone
