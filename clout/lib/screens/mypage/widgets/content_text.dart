import 'package:flutter/material.dart';

class ContentText extends StatelessWidget {
  const ContentText({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(fontSize: 17),
      textAlign: TextAlign.start,
    );
  }
}
