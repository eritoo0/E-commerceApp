import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';

class SignInUpPrompt extends StatelessWidget {
  final String txtOne;
  final String txtTwo;
  final VoidCallback onPressed;
  const SignInUpPrompt(
      {super.key,
      required this.txtOne,
      required this.txtTwo,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          txtOne,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            txtTwo,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ColorApp.primaryColor),
          ),
        ),
      ],
    );
  }
}
