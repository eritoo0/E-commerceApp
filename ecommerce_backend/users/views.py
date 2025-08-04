from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .serializers import UserSerializer
from django.contrib.auth import get_user_model

from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token

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

        user = authenticate(request, username=email, password=password)

        if user is not None:
            if not user.users_approve:
                return Response({"message": "Account not approved"}, status=status.HTTP_403_FORBIDDEN)

            # Optional: Use Django Token Auth (or JWT)
            token, created = Token.objects.get_or_create(user=user)

            return Response({
                "message": "Login successful",
                "token": token.key,
                "user": UserSerializer(user).data
            })

        return Response({"message": "Invalid email or password"}, status=status.HTTP_401_UNAUTHORIZED)
