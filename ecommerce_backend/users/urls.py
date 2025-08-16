from django.urls import path
from .views import SignupView, LoginView, VerifyCodeView , ResendCodeView , ForgotPasswordView , VerifyResetCodeView , ResetPasswordView

urlpatterns = [
    path("signup/", SignupView.as_view(), name="signup"),
    path("login/", LoginView.as_view(), name="login"),
    path("verify/", VerifyCodeView.as_view()),
    path("resend-code/", ResendCodeView.as_view()),
    
    path('forgot-password/', ForgotPasswordView.as_view(), name='forgot_password'),
    path('verify-reset-code/', VerifyResetCodeView.as_view(), name='verify_reset_code'),
    path('reset-password/', ResetPasswordView.as_view(), name='reset_password'),
]
