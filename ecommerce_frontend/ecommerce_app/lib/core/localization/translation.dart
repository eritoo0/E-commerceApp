import 'package:get/get.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en": {
          "Choose Language": "Choose Language",
          "next": "Next",
          "skip": "Skip",
          "start": "Get Started",
          "welcome": "Welcome Back",
          "login": "Login",
          "signup": "Sign Up",
          "don't_have_account": "Don't have an account? ",
          "have_an_account": "Already have an account?",
          "name": "Username",
          "name_hint": "Enter your username",
          "fullname": "Full Name",
          "fullname_hint": "Enter your full name",
          "phone": "Phone Number",
          "phone_hint": "Enter your phone number",
          "email": "Email",
          "password": "Password",
          "forgetPassword": "Forget Password",
          "check_email": "Check Your Email",
          'check_email_title': 'Email Verification',
          'check_email_instruction':
              'Please enter the email you used during registration to verify your account.',
          "check_email_sentence":
              "We are going to send you an email to reset your password.",
          "verifyCode": "Verify Code",
          "check_code": "Check the code",
          "check_code_sentence":
              "Please enter the 5-digit code sent to your email.",
          "reset_password": "Reset Password",
          "reset_your_password": "Reset your password",
          "reset_pass_sentence": "Please enter a new password  .",
          "reset_pass": "validate",
          'email_hint': 'Enter your email',
          'password_hint': 'Enter your password',
          "reenter_password_hint": "Re-enter your password",
          "confirm_password": "Confirm Password",
          "fullname_not_valid": "Enter at least 3 letters",
          "email_not_valid": "Enter a valid email",
          "phone_not_valid": "Enter a valid phone number",
          "password_not_valid":
              "Password must be at least 6 characters, with numbers",
          "required": "This field is required",
          'username_length':
              'Username must be between {min} and {max} characters.',
          'username_not_valid': 'Username is not valid.',
          'password_length':
              'Password must be between {min} and {max} characters.',
          'password_too_short':
              'Password must be at least {min} characters long.',
          'remember_me': 'Remember me',
          'forgot_password': 'Forgot password?',
          "logout": "Logout",
          "language": "Language",
          'onboarding_title_1': 'Choose Product',
          'onboarding_body_1':
              'Browse more than 100,000 items.\nFind everything you need easily\nin our e-commerce store.',
          'onboarding_title_2': 'Easy & Secure Payment',
          'onboarding_body_2':
              'Pay safely with trusted methods.\nWe support credit cards, PayPal,\nand more secure options.',
          'onboarding_title_3': 'Track Your Order',
          'onboarding_body_3':
              'Stay updated with real-time tracking.\nKnow where your package is,\nand when it will arrive.',
          'onboarding_title_4': 'Fast Delivery',
          'onboarding_body_4':
              'Enjoy fast and reliable delivery.\nYour products will reach your door\nquickly and safely.',
          'login_sentence':
              'Sign in with your email and password, or continue with social media.',
          'signup_success_title': 'Sign Up Successful!',
          'signup_success_subtitle':
              'Your account has been created successfully.',
          'go_to_home': 'Go to Home',
          'reset_success_title': 'Password Reset Successful!',
          'reset_success_subtitle':
              'Your password has been updated successfully.',
          'go_to_login': 'Back to Login',
          "exit_title": "Exit App",
          "exit_message": "Are you sure you want to exit the application?",
          "cancel": "Cancel",
          "exit": "Exit",
        },
        "fr": {
          "Choose Language": "Choisir la langue",
          "next": "Suivant",
          "skip": "Passer",
          "start": "Commencer",
          "welcome": "Bienvenue",
          "login": "Se connecter",
          "signup": "S'inscrire",
          "don't_have_account": "Vous n'avez pas de compte ? ",
          "have_an_account": "Vous avez déjà un compte ?",
          "name": "Nom d'utilisateur",
          "name_hint": "Entrez votre nom d'utilisateur",
          "fullname": "Nom complet",
          "fullname_hint": "Entrez votre nom complet",
          "phone": "Numéro de téléphone",
          "phone_hint": "Entrez votre numéro de téléphone",
          "email": "E-mail",
          "password": "Mot de passe",
          "forgetPassword": "Mot de passe oublié",
          "check_email": "Vérifiez votre e-mail",
          'check_email_title': 'Vérification d\'email',
          'check_email_instruction':
              'Veuillez saisir l\'adresse e-mail utilisée lors de votre inscription pour vérifier votre compte.',
          "check_email_sentence":
              "Nous allons vous envoyer un e-mail pour réinitialiser votre mot de passe.",
          "verifyCode": "Vérifier le code",
          "check_code": "Vérifiez le code",
          "check_code_sentence":
              "Veuillez saisir le code à 5 chiffres envoyé à votre e-mail.",
          "reset_password": "Réinitialiser le mot de passe",
          "reset_your_password": "Réinitialisez votre mot de passe",
          "reset_pass_sentence": "Veuillez entrer un nouveau mot de passe.",
          "reset_pass": "Valider",
          'email_hint': 'Entrez votre e-mail',
          'password_hint': 'Entrez votre mot de passe',
          "reenter_password_hint": "Saisissez à nouveau votre mot de passe",
          "confirm_password": "Confirmer le mot de passe",
          "fullname_not_valid": "Entrez au moins 3 lettres",
          "email_not_valid": "Entrez un email valide",
          "phone_not_valid": "Entrez un numéro de téléphone valide",
          "password_not_valid":
              "Le mot de passe doit contenir au moins 6 caractères avec des chiffres",
          "required": "Ce champ est requis",
          'username_length':
              'Le nom d\'utilisateur doit comporter entre {min} et {max} caractères.',
          'username_not_valid': 'Le nom d\'utilisateur n\'est pas valide.',
          'password_length':
              'Le mot de passe doit comporter entre {min} et {max} caractères.',
          'password_too_short':
              'Le mot de passe doit comporter au moins {min} caractères.',
          'remember_me': 'Se souvenir de moi',
          'forgot_password': 'Mot de passe oublié ?',
          "logout": "Se déconnecter",
          "language": "Langue",
          'onboarding_title_1': 'Choisir un produit',
          'onboarding_body_1':
              'Parcourez plus de 100 000 articles.\nTrouvez tout ce dont vous avez besoin facilement\nsur notre boutique en ligne.',
          'onboarding_title_2': 'Paiement facile et sécurisé',
          'onboarding_body_2':
              'Payez en toute sécurité avec des méthodes fiables.\nNous acceptons les cartes, PayPal,\net d\'autres options sécurisées.',
          'onboarding_title_3': 'Suivez votre commande',
          'onboarding_body_3':
              'Restez informé grâce au suivi en temps réel.\nSuivez votre colis et sachez quand il arrive.',
          'onboarding_title_4': 'Livraison rapide',
          'onboarding_body_4':
              'Profitez d\'une livraison rapide et fiable.\nVos produits arriveront rapidement et en toute sécurité.',
          'login_sentence':
              'Connectez-vous avec votre e-mail et mot de passe, ou continuez avec les réseaux sociaux.',
          'signup_success_title': 'Inscription réussie !',
          'signup_success_subtitle': 'Votre compte a été créé avec succès.',
          'go_to_home': 'Aller à l\'accueil',
          'reset_success_title': 'Réinitialisation réussie !',
          'reset_success_subtitle':
              'Votre mot de passe a été mis à jour avec succès.',
          'go_to_login': 'Retour à la connexion',
          "exit_title": "Quitter l'application",
          "exit_message": "Êtes-vous sûr de vouloir quitter l'application ?",
          "cancel": "Annuler",
          "exit": "Quitter"
        },
        "ar": {
          "Choose Language": "اختر اللغة",
          "next": "التالي",
          "skip": "تخطي",
          "start": "ابدأ الآن",
          "welcome": "مرحبا",
          "login": "تسجيل الدخول",
          "signup": "إنشاء حساب",
          "don't_have_account": "ليس لديك حساب؟ ",
          "have_an_account": "هل لديك حساب بالفعل؟",
          "name": "اسم المستخدم",
          "name_hint": "أدخل اسم المستخدم",
          "fullname": "الاسم الكامل",
          "fullname_hint": "أدخل الاسم الكامل",
          "phone": "رقم الهاتف",
          "phone_hint": "أدخل رقم هاتفك",
          "email": "البريد الإلكتروني",
          "password": "كلمة المرور",
          "forgetPassword": "نسيت كلمة المرور",
          "check_email": "تحقق من بريدك الإلكتروني",
          "check_email_sentence":
              "سنرسل لك بريدًا إلكترونيًا لإعادة تعيين كلمة المرور.",
          'check_email_title': 'تأكيد البريد الإلكتروني',
          'check_email_instruction':
              'يرجى إدخال البريد الإلكتروني الذي استخدمته أثناء التسجيل للتحقق من حسابك.',
          "verifyCode": "تأكيد الرمز",
          "check_code": "تحقق من الرمز",
          "check_code_sentence":
              "يرجى إدخال الرمز المكون من 5 أرقام المرسل إلى بريدك الإلكتروني.",
          "reset_password": "إعادة تعيين كلمة المرور",
          "reenter_password_hint": "أعد إدخال كلمة المرور",
          "reset_your_password": "أعد تعيين كلمة المرور",
          "reset_pass_sentence": "يرجى إدخال كلمة مرور جديدة.",
          "reset_pass": "تأكيد",
          'email_hint': 'أدخل بريدك الإلكتروني',
          'password_hint': 'أدخل كلمة المرور',
          "confirm_password": "تأكيد كلمة المرور",
          "fullname_not_valid": "أدخل 3 أحرف على الأقل",
          "email_not_valid": "أدخل بريدًا إلكترونيًا صحيحًا",
          "phone_not_valid": "أدخل رقم هاتف صحيح",
          "password_not_valid":
              "يجب أن تكون كلمة المرور 6 أحرف على الأقل وتحتوي على أرقام",
          "required": "هذا الحقل مطلوب",
          'username_length':
              'يجب أن يتراوح اسم المستخدم بين {min} و {max} حرفًا.',
          'username_not_valid': 'اسم المستخدم غير صالح.',
          'password_length':
              'يجب أن يتراوح طول كلمة المرور بين {min} و {max} حرفًا.',
          'password_too_short':
              'يجب أن تكون كلمة المرور على الأقل {min} حرفًا.',
          'remember_me': 'تذكرني',
          'forgot_password': 'هل نسيت كلمة المرور؟',
          "logout": "تسجيل الخروج",
          "language": "اللغة",
          'onboarding_title_1': 'اختر المنتج',
          'onboarding_body_1':
              'تصفح أكثر من 100,000 منتج.\nابحث بسهولة عن كل ما تحتاجه\nفي متجرنا الإلكتروني.',
          'onboarding_title_2': 'دفع سهل وآمن',
          'onboarding_body_2':
              'ادفع بأمان باستخدام وسائل موثوقة.\nندعم البطاقات، PayPal، والمزيد من الطرق الآمنة.',
          'onboarding_title_3': 'تتبع طلبك',
          'onboarding_body_3':
              'ابقَ على اطلاع مع التتبع اللحظي.\nاعرف مكان الطرد ومتى سيصل.',
          'onboarding_title_4': 'توصيل سريع',
          'onboarding_body_4':
              'استمتع بتوصيل سريع وآمن.\nمنتجاتك ستصل إلى بابك بسرعة وأمان.',
          'login_sentence':
              'سجّل الدخول باستخدام بريدك الإلكتروني وكلمة المرور، أو تابع عبر وسائل التواصل الاجتماعي.',
          'signup_success_title': 'تم التسجيل بنجاح!',
          'signup_success_subtitle': 'تم إنشاء حسابك بنجاح.',
          'go_to_home': 'اذهب إلى الصفحة الرئيسية',
          'reset_success_title': 'تمت إعادة تعيين كلمة السر!',
          'reset_success_subtitle': 'تم تحديث كلمة المرور بنجاح.',
          'go_to_login': 'العودة إلى تسجيل الدخول',
          "exit_title": "الخروج من التطبيق",
          "exit_message": "هل أنت متأكد أنك تريد الخروج من التطبيق؟",
          "cancel": "إلغاء",
          "exit": "خروج",
        },
      };
}
