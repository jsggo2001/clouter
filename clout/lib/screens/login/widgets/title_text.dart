// global
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

class TitleText extends StatelessWidget {
  TitleText({super.key, this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.textTheme.titleMedium?.copyWith(color: style.colors['text']),
    );
  }
}
