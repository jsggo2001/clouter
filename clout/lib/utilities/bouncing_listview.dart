import 'package:flutter/material.dart';

class BouncingListview extends StatelessWidget {
  BouncingListview({
    super.key,
    this.child,
    this.scrollDirection = Axis.vertical,
  });

  final Widget? child;
  final Axis scrollDirection;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: scrollDirection,
        physics: BouncingScrollPhysics(),
        child: child);
  }
}
