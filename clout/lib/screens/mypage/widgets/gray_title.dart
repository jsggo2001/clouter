import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class GrayTitle extends StatelessWidget {
  const GrayTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(color: style.colors['gray'], fontSize: 17));
  }
}
