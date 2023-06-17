from django.contrib.auth import get_user_model
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from . models import User

class CustomRegisterSerializer(serializers.ModelSerializer):

    name = serializers.CharField(max_length=100)
    email = serializers.EmailField(required = True, 
                                   validators= [UniqueValidator(queryset=get_user_model().objects.all(), message= 'Email Already Exists')])

    class Meta:
        model = User
        fields = [
            'name',
            'email',
            'password'
        ]

    def create(self, validated_data):
        user = User.objects.create_user(
            name=validated_data['name'],
            email=validated_data['email'],
            password=validated_data['password']
        )

        user.save()
        return user
