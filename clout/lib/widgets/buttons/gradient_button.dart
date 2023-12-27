import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class GradientButton extends StatelessWidget {
  const GradientButton(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(70)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF6B4EFF),
                  Color.fromARGB(255, 177, 167, 235),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Icons.chevron_right, color: Colors.white),
              ],
            )),
        Positioned.fill(
          top: 0,
          left: 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}
