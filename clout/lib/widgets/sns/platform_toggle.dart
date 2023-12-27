import 'package:clout/providers/platform_select_controller.dart';
import 'package:clout/widgets/sns/widgets/sns3_select_box.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

class PlatformToggle extends StatelessWidget {
  PlatformToggle(
      {super.key, required this.multiAllowed, required this.controllerTag});
  final multiAllowed;
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        color: Colors.white,
        width: screenWidth,
        // height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            Expanded(
              child: Sns3SelectBox(
                img: 'assets/images/INSTAGRAM.png',
                index: 0,
                title: 'Instagram',
                multiAllowed: multiAllowed,
                controllerTag: controllerTag,
              ),
            ),
            Expanded(
              child: Sns3SelectBox(
                img: 'assets/images/TIKTOK.png',
                index: 1,
                title: 'Tiktok',
                multiAllowed: multiAllowed,
                controllerTag: controllerTag,
              ),
            ),
            Expanded(
              child: Sns3SelectBox(
                img: 'assets/images/YOUTUBE.png',
                index: 2,
                title: 'Youtube',
                multiAllowed: multiAllowed,
                controllerTag: controllerTag,
              ),
            ),
            SizedBox(width: 5),
          ],
        ));
  }
}
