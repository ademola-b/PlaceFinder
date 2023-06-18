from django.urls import path
from . views import LocationsView, LocationDelete

urlpatterns = [
    path('', LocationsView.as_view(), name="location"),
    path('delete/<str:pk>/', LocationDelete.as_view(), name="delete_location"),
    path('update/<str:pk>/', LocationDelete.as_view(), name="update_location"),
]
