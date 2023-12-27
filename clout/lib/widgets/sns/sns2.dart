import 'package:clout/type.dart';
import 'package:flutter/material.dart';

class Sns2 extends StatelessWidget {
  const Sns2({super.key, required this.platform});

  final String platform;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 2),
      child:
          Image.asset('assets/images/${platform}.png', width: 20, height: 20),
    );
  }
}
