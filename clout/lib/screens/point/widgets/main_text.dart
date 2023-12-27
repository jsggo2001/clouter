import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  const MainText({super.key, required this.textTitle});

  final String textTitle;

  @override
  Widget build(BuildContext context) {
    return Text(textTitle,
        style: TextStyle(
          fontSize: 26,
        ));
  }
}
