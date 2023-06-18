from django.shortcuts import render
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from . models import Location
from . serializers import LocationsSerializer
# Create your views here.
class LocationsView(ListCreateAPIView):
    queryset = Location.objects.all()
    serializer_class = LocationsSerializer

    def get_queryset(self):
        
        if not self.request.user.is_authenticated:
            return Location.objects.none()
        return super().get_queryset()

class LocationDelete(RetrieveUpdateDestroyAPIView):
    queryset = Location.objects.all()
    serializer_class = LocationsSerializer
    
    