import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

class SmallButton extends StatelessWidget {
  SmallButton({
    super.key,
    this.title,
    this.destination,
    this.function,
    this.notJustRoute,
    this.buttonHeight = 38,
  });

  final title;
  final destination;
  final function;
  final notJustRoute;
  final double buttonHeight;

  @override
  Widget build(BuildContext context) {
    final textSize = (buttonHeight * 0.3)
        .clamp(13.0, double.infinity); // 버튼 높이에 따라 fontSize 계산

    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          if (destination != null) {
            if (notJustRoute != null && notJustRoute) {
              function(destination);
            } else {
              Get.toNamed(destination);
            }
          } else {
            function();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: style.colors['main1'],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: textSize,
            color: style.colors['white'],
            fontWeight: FontWeight.w400,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
