from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import UserSerializer
from rest_framework.authtoken.models import Token
from django.contrib.auth import get_user_model, authenticate
from django.contrib.auth.hashers import check_password

User = get_user_model()

class SignupView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(users_approve=False)  # default to unapproved
            return Response({'message': 'User created successfully', 'user': serializer.data}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    




class LoginView(APIView):
    def post(self, request):
        email = request.data.get("email")
        password = request.data.get("password")

        try:
            user = User.objects.get(email=email)

            if not check_password(password, user.password):
                return Response({"message": "Wrong password"}, status=401)

            if not user.users_approve:
                return Response({"message": "User not approved"}, status=403)

            token, created = Token.objects.get_or_create(user=user)

            return Response({
                "token": token.key,
                "user": UserSerializer(user).data
            })

        except User.DoesNotExist:
            return Response({"message": "User not found"}, status=404)