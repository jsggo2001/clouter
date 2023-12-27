import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  const MediumText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: TextStyle(fontSize: 20));
  }
}
