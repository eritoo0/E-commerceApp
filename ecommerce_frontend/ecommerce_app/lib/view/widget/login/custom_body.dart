import 'package:flutter/material.dart';

class CustomBody extends StatelessWidget {
  final String bodyText;
  const CustomBody({super.key, required this.bodyText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Text(
        bodyText,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
