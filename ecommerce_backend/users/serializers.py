from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from django.contrib.auth import get_user_model

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(
        required=True,
        validators=[UniqueValidator(queryset=User.objects.all(), message="Email must be unique.")]
    )
    username = serializers.CharField(required=False, allow_blank=True, allow_null=True, max_length=150)
    users_phone = serializers.CharField(
        required=False, allow_blank=True, allow_null=True, max_length=20,
        validators=[UniqueValidator(queryset=User.objects.all(), message="Phone must be unique.")]
    )

    class Meta:
        model = User
        fields = ['id','username','email','users_phone','users_verfiycode','users_approve','users_create','password']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        password = validated_data.pop('password', None)
        user = User(**validated_data)
        if password:
            user.set_password(password)
        user.save()
        return user
