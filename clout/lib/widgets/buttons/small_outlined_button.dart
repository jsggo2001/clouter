import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class SmallOutlinedButton extends StatelessWidget {
  const SmallOutlinedButton({super.key, required this.title, this.onPressed});

  final String title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.add, size: 18),
      label: Text(title),
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 10, 20, 10)),
        foregroundColor: MaterialStateProperty.all(style.colors['main1']),
        side: MaterialStateProperty.all(
          BorderSide(
              color: Color(0xFF6B4EFF), width: 1.0, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
