from rest_framework import serializers
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import make_password

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'id',
            'username',
            'email',
            'password',
            'users_phone',
            'users_verfiycode',
            'users_approve',
            'users_create'
        ]
        extra_kwargs = {
            'password': {'write_only': True},  # hide in response
            'users_verfiycode': {'write_only': True},
            'users_approve': {'read_only': True},
            'users_create': {'read_only': True}
        }

    def create(self, validated_data):
        # Hash the password before saving
        validated_data['password'] = make_password(validated_data['password'])
        return super().create(validated_data)
