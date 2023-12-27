// Global
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

class MainCarouselText1 extends StatelessWidget {
  MainCarouselText1({super.key, this.text});

  final text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.textTheme.headlineMedium
          ?.copyWith(color: style.colors['white'], fontWeight: FontWeight.w600),
    );
  }
}
