import 'package:clout/providers/platform_select_controller.dart';
import 'package:flutter/material.dart'
    hide BoxDecoration, BoxShadow; //  기존 BoxShadow 속성을 가려줘야 함
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class AvailablePlatform extends StatelessWidget {
  AvailablePlatform({
    super.key,
    required this.platform,
  });
  final platform;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          color: style.colors['main3'],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 0),
                inset: true),
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(2, 4))
          ],
        ),
        padding: EdgeInsets.all(10),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 5,
          runSpacing: 5,
          children: [
            Image.asset(
              'assets/images/$platform.png',
              width: 50,
              fit: BoxFit.fitWidth,
            ),
            Text(
              platform,
              style: style.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
