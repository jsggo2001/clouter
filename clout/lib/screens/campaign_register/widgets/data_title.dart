// Global
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class DataTitle extends StatelessWidget {
  const DataTitle({super.key, this.text});
  final text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.textTheme.headlineMedium
          ?.copyWith(color: style.colors['text'], fontWeight: FontWeight.w600),
      overflow: TextOverflow.ellipsis,
    );
  }
}
