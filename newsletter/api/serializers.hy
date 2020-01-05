(import [rest_framework [serializers]]
        [newsletter.models [Subscriber]])

(defclass SubscriberSerializer [serializers.ModelSerializer]
  (setv joined_date (.DateTimeField serializers :format "%a, %d %b  %I:%M %p" :read_only True))
  (defclass Meta []
    [model Subscriber
     fields  "__all__"]))
