(import [django.test [TestCase]]
        [rest_framework [status]]
        [rest_framework.test [APIClient]]
        [newsletter.models [Subscriber]]
        [accounts.models [CustomUser]]
        [newsletter.api.serializers [SubscriberSerializer]]
        [newsletter.api.views [Subscribers]])

; Create your tests here.
(defclass CreateViewSubscribersTest [TestCase]
  (defn setUp [self]
    (setv self.client (APIClient))
    ; Create superuser
    (setv self.superuser (.create_superuser CustomUser.objects
        :username "Superuser Testing"
        :email "superuser@testing.com"
        :password "superusertestingpassword"))
    (.save self.superuser)

    ; Create regular user
    (setv self.user (.create_user CustomUser.objects
        :username "Regular User"
        :email "regularuser@testing.com"
        :password "regularusertestingpassword"))
    (.save self.user))

  ;Tests whether non-authenticated user can view all subscribers via GET request
  (defn test_not_authenticated_view_subscribers [self]
    (setv response (.get self.client :path "/api/subscribers/"))
    (.assertEqual self response.status_code status.HTTP_401_UNAUTHORIZED))
  
  ;Tests whether authenticated (but not superuser) user can view all subscribers via GET request"
  (defn test_authenticated_and_not_superuser_view_subscribers [self]
    (.login self.client :email "regularuser@testing.com" :password "regularusertestingpassword")
    (setv response (.get self.client :path "/api/subscribers/")
          subscribers (.all Subscriber.objects)
          serializer (SubscriberSerializer subscribers :many True))
    (.logout self.client)
    (.assertNotEqual self response.data serializer.data)
    (.assertEqual self response.status_code status.HTTP_403_FORBIDDEN))
  
  ;Tests whether admin user can view all subscribers via GET request
  (defn test_admin_view_subscribers [self]
    (.login self.client :email "superuser@testing.com" :password "superusertestingpassword")
    (setv response (.get self.client :path "/api/subscribers/")
          subscribers (.all Subscriber.objects)
          serializer (SubscriberSerializer subscribers :many True))
    (.logout self.client)
    (.assertEqual self response.data serializer.data)
    (.assertEqual self response.status_code status.HTTP_200_OK))
  
  ;Tests whether a subscriber with a valid email address can be created
  (defn test_create_valid_subscriber [self]
    (setv response (.post self.client :path "/api/subscribers/" :data {"email" "abc123@abc.com"}))
    (.assertEqual self (get response.data "email") "abc123@abc.com")
    (.assertEqual self response.status_code status.HTTP_201_CREATED))
  
  (defn test_create_invalid_subscriber [self]
    (setv response (.post self.client :path "/api/subscribers/" :data {"email" "asdfadsgcvv2dvsdfg.asda.c/afd"}))
    (.assertEqual self (get (get response.data "email") 0) "Enter a valid email address.")
    (.assertEqual self response.status_code status.HTTP_400_BAD_REQUEST))
  
  (defn test_create_existing_subscriber [self]
    ;Create sample subscriber
    (.create Subscriber.objects :email "samplesubscriber@abc.com")
  
    (setv response .post self.client :path "/api/subscribers/" :data {"email" "samplesubscriber@abc.com"})
    (.assertEqual self (get (get response.data "email") 0) "Subscriber with this email already exists.")
    (.assertEqual self response.status_code status.HTTP_400_BAD_REQUEST))
  
  (defn test_string_representation [self]
    (setv subscriber (.create Subscriber.objects :email "samplesubscriber@abc.com"))
    (.assertEqual self (str subscriber) "samplesubscriber@abc.com")))

