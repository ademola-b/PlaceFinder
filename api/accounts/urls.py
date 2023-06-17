from django.urls import path, include
from . views import CustomRegisterView

urlpatterns = [
    path('', include('dj_rest_auth.urls')),
    # path('registration/', include('dj_rest_auth.registration.urls')),
    path('register/', CustomRegisterView.as_view(), name="register"),
  ]
