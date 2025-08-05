from django.urls import path
from .views import SignupView, LoginView, VerifyCodeView , ResendCodeView

urlpatterns = [
    path("signup/", SignupView.as_view(), name="signup"),
    path("login/", LoginView.as_view(), name="login"),
    path("verify/", VerifyCodeView.as_view()),
    path("resend-code/", ResendCodeView.as_view()),
]
