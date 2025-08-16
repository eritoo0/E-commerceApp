from rest_framework.views import APIView
from rest_framework.response import Response
import random
from django.core.mail import send_mail
from rest_framework import status
from .serializers import UserSerializer
from rest_framework.authtoken.models import Token
from django.contrib.auth import get_user_model, authenticate
from django.contrib.auth.hashers import check_password
from .models import CustomUser

User = get_user_model()

class SignupView(APIView):
    def post(self, request):
        data = request.data.copy()
        
        # Generate 6-digit code
        verification_code = str(random.randint(100000, 999999))
        data["users_verfiycode"] = verification_code
        data["users_approve"] = False

        serializer = UserSerializer(data=data)
        if serializer.is_valid():
            user = serializer.save()

            # Send email with code
            send_mail(
                subject="Your Verification Code",
                message=f"Hello {user.username}, your verification code is: {verification_code}",
                from_email="youremail@gmail.com",  # must match EMAIL_HOST_USER
                recipient_list=[user.email],
                fail_silently=False
            )

            return Response({"message": "User created and code sent", "user": serializer.data}, status=201)

        return Response(serializer.errors, status=400)



class LoginView(APIView):
    def post(self, request):
        email = request.data.get("email")
        password = request.data.get("password")

        try:
            user = User.objects.get(email=email)

            if not check_password(password, user.password):
                return Response({"message": "Wrong password"}, status=401)

            # if not user.users_approve:
            #     return Response({"message": "User not approved"}, status=403)
            if not user.users_approve:
                return Response({'message': 'Account not verified'}, status=status.HTTP_403_FORBIDDEN)


            token, created = Token.objects.get_or_create(user=user)

            return Response({
                "token": token.key,
                "user": UserSerializer(user).data
            })

        except User.DoesNotExist:
            return Response({"message": "User not found"}, status=404)
        
        

class VerifyCodeView(APIView):
    def post(self, request):
        email = request.data.get('email')
        code = request.data.get('verifycode')

        try:
            user = CustomUser.objects.get(email=email)
            if user.users_verfiycode == code:
                user.users_approve = True
                user.save()
                return Response({'message': 'Account verified successfully'}, status=status.HTTP_200_OK)
            else:
                return Response({'message': 'Invalid verification code'}, status=status.HTTP_400_BAD_REQUEST)
        except CustomUser.DoesNotExist:
            return Response({'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
        
    
        
        

class ResendCodeView(APIView):
    def post(self, request):
        email = request.data.get('email')

        try:
            user = CustomUser.objects.get(email=email)
            new_code = str(random.randint(100000, 999999))
            user.users_verfiycode = new_code
            user.save()

            send_mail(
                'Your new verification code',
                f'Your new code is: {new_code}',
                'your_email@gmail.com',
                [user.email],
                fail_silently=False,
            )

            return Response({'message': 'Verification code resent'}, status=status.HTTP_200_OK)
        except CustomUser.DoesNotExist:
            return Response({'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
        
        
        

class ForgotPasswordView(APIView):
    def post(self, request):
        email = (request.data.get('email') or '').strip().lower()
        if not email:
            return Response({'message': 'Email is required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = CustomUser.objects.get(email=email)

            # use if just userapprove allowed / 
            # if not user.users_approve:
            #     return Response({'message': 'Account not verified'}, status=status.HTTP_403_FORBIDDEN)

            # generate 6-digit code and store it in users_verfiycode
            reset_code = str(random.randint(100000, 999999))
            user.users_verfiycode = reset_code
            user.save(update_fields=['users_verfiycode'])

            send_mail(
                subject='Password reset code',
                message=f'Your password reset code is: {reset_code}',
                from_email='youremail@gmail.com',
                recipient_list=[user.email],
                fail_silently=False,
            )

            # To avoid leaking whether an email exists, you can always return 200 with the same message.
            return Response({'message': 'If the email exists, a reset code was sent.'}, status=status.HTTP_200_OK)

        except CustomUser.DoesNotExist:
            # same response to avoid user enumeration
            return Response({'message': 'If the email exists, a reset code was sent.'}, status=status.HTTP_200_OK)



class VerifyResetCodeView(APIView):
    def post(self, request):
        email = (request.data.get('email') or '').strip().lower()
        code = (request.data.get('verifycode') or '').strip()

        if not email or not code:
            return Response({'message': 'Email and code are required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = CustomUser.objects.get(email=email)
            if user.users_verfiycode == code:
                return Response({'message': 'Code verified'}, status=status.HTTP_200_OK)
            return Response({'message': 'Invalid or expired code'}, status=status.HTTP_400_BAD_REQUEST)
        except CustomUser.DoesNotExist:
            return Response({'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)


class ResetPasswordView(APIView):
    def post(self, request):
        email = (request.data.get('email') or '').strip().lower()
        code = (request.data.get('verifycode') or '').strip()
        new_password = request.data.get('new_password') or ''

        if not email or not code or not new_password:
            return Response({'message': 'Email, code, and new_password are required'}, status=status.HTTP_400_BAD_REQUEST)
        if len(new_password) < 6:
            return Response({'message': 'Password must be at least 6 characters'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = CustomUser.objects.get(email=email)
            if user.users_verfiycode != code:
                return Response({'message': 'Invalid or expired code'}, status=status.HTTP_400_BAD_REQUEST)

            # set the new password
            user.set_password(new_password)
            # clear the code so it can’t be reused
            user.users_verfiycode = ''
            user.save(update_fields=['password', 'users_verfiycode'])

            return Response({'message': 'Password updated'}, status=status.HTTP_200_OK)

        except CustomUser.DoesNotExist:
            return Response({'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)