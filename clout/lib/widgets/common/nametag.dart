import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class NameTag extends StatelessWidget {
  const NameTag({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, right: 4),
      child: SizedBox(
        width: 70,
        height: 25,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: style.colors['category'],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: style.colors['white'],
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
