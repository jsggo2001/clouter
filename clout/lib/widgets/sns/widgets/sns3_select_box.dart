import 'package:clout/providers/platform_select_controller.dart';
import 'package:flutter/material.dart'
    hide BoxDecoration, BoxShadow; //  기존 BoxShadow 속성을 가려줘야 함
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class Sns3SelectBox extends StatelessWidget {
  const Sns3SelectBox(
      {super.key,
      required this.img,
      required this.index,
      required this.title,
      required this.multiAllowed,
      required this.controllerTag});
  final img;
  final index;
  final title;
  final multiAllowed;
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlatformSelectController>(
      tag: controllerTag,
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal:5),
        child: Container(
          decoration: BoxDecoration(
              color: controller.platforms[index]
                  ? style.colors['category']
                  : style.colors['main3'],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: controller.platforms[index]
                  ? [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(2, 4),
                          inset: true)
                    ]
                  : [
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
                    ]),
          padding: EdgeInsets.all(10),
          child: InkWell(
            onTap: () => controller.setSelected(index, multiAllowed),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              runSpacing: 5,
              children: [
                Image.asset(
                  img,
                  width: 50,
                  fit: BoxFit.fitWidth,
                ),
                Text(
                  title,
                  style: style.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
