import base64

from django.contrib.auth import get_user_model
import django.contrib.auth.password_validation as validators
from django.core import exceptions
from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from dj_rest_auth.serializers import UserDetailsSerializer
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

    def validate(self, attrs):
        user = User(**attrs)
        password = attrs.get('password')
        errors = dict()
        try:
            validators.validate_password(password=password, user=user)
        except exceptions.ValidationError as e:
            errors['password'] = list(e.messages)
        
        if errors:
            raise serializers.ValidationError(errors)

        return super().validate(attrs)
    
    
    def create(self, validated_data):
        user = User.objects.create_user(
            name=validated_data['name'],
            email=validated_data['email'],
            password=validated_data['password']
        )

        user.save()
        return user


class UserDetailsSerializer(UserDetailsSerializer):
    is_staff = serializers.BooleanField()
    # picture_memory = serializers.SerializerMethodField("get_image_memory")

    class Meta(UserDetailsSerializer.Meta):
        fields = UserDetailsSerializer.Meta.fields + ('name','is_staff','picture', ) 
        read_only_fields = ('email', 'is_staff')

    def get_image_memory(request, user:User):
        with open(user.picture.name, 'rb') as loadedfile:
            return base64.b64encode(loadedfile.read())

