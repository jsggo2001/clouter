import 'package:clout/providers/region_controller.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RegionMultiselectChip extends StatelessWidget {
  RegionMultiselectChip({super.key, this.title, this.controllerTag});

  final title;
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionController>(
      tag: controllerTag,
      builder: (controller) => Container(
        padding: EdgeInsets.all(2.5),
        child: ElevatedButton(
          onPressed: () {
            controller.removeRegion(title);
            for (int i = 0; i < controller.regionsSelectedBool.length; i++) {
              if (controller.regionsSelectedBool[i].region == title) {
                controller.regionsSelectedBool[i].selected = false;
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: style.colors['main1'],
            padding: EdgeInsets.only(left: 15, right: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              side: BorderSide.none,
            ),
            elevation: 0,
          ),
          child: Wrap(
            spacing: 5,
            children: [
              Icon(
                Icons.close_outlined,
                size: 15,
              ),
              Text(
                title,
                style: TextStyle(height: 1.2, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
