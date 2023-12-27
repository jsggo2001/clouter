import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class RefreshableContainer extends StatelessWidget {
  RefreshableContainer(
      {super.key,
      required this.controller,
      required this.child,
      this.heightPadding}) {
    heightPadding ??= 90;
  }
  ScrollController
      controller; // 사용하는 controller 내부에 정의된 ScrollController를 인자로 받아야 함 나머지 설정은 controller에서 할것
  Widget child;
  int? heightPadding;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      controller: controller,
      physics: BouncingScrollPhysics(),
      child: Container(
        constraints: BoxConstraints(minHeight: screenHeight - heightPadding!),
        // color: Colors.blue,
        child: Align(alignment: Alignment.topCenter, child: child),
      ),
    );
  }
}
