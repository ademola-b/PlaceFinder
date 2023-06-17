from django.contrib.auth import get_user_model
from django.shortcuts import render
from rest_framework import permissions
from rest_framework.response import Response
from rest_framework import generics, status
from . models import User
from . serializers import CustomRegisterSerializer

# Create your views here.
class CustomRegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = CustomRegisterSerializer
    # permission_classes = [permissions.AllowAny]

    def create(self, request, *args, **kwargs):
        """Creates a user"""
        super().create(request, *args, **kwargs)
        return Response(status=status.HTTP_201_CREATED)