import 'package:ecommerce_app/core/constant/color.dart';
import 'package:ecommerce_app/view/widget/language/language_button.dart';
import 'package:flutter/material.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorApp.bgColorLangBeg,
              ColorApp.bgColorLangEnd,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Choose Language",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: 60,
            ),
            const LanguageButton(
                label: "English 🇬🇧", locale: Locale("en", "US")),
            const SizedBox(
              height: 20,
            ),
            const LanguageButton(
                label: "Français 🇫🇷", locale: Locale("fr", "FR")),
            const SizedBox(
              height: 20,
            ),
            const LanguageButton(
                label: "العربية 🇩🇿", locale: Locale("ar", "DZ")),
          ],
        ),
      ),
    );
  }
}
