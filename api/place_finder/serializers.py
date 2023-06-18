from  rest_framework import serializers
from rest_framework.validators import UniqueValidator
from . models import Location


class LocationsSerializer(serializers.ModelSerializer):

    name = serializers.CharField(validators = [UniqueValidator(queryset=Location.objects.all(), message="Location Already Exists")])

    class Meta:
        model = Location
        fields = [
            'location_id',
            'name', 
            'latitude',
            'longitude',
        ]

    