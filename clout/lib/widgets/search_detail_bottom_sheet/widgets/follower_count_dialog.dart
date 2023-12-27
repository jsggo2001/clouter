// Global
import 'package:clout/providers/follower_controller.dart';
import 'package:clout/providers/platform_select_controller.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

// Widgets
import 'package:clout/hooks/numeric_range_formatter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

//이건 getX 쓸때 쓰는 컴포넌트임 일반으로 쓰는 컴포넌트는 followercount_input_dialog.dart
class FollowerCountDialog extends StatelessWidget {
  FollowerCountDialog(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controllerTag,
      this.index});

  final title;
  final hintText;
  final controllerTag;
  final index;

  void openDialog() {
    Get.defaultDialog(
      title: title,
      titlePadding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      content: GetBuilder<FollowerController>(
        tag: controllerTag,
        builder: (controller) => SizedBox(
          height: 75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                inputFormatters: [
                  NumericRangeFormatter(min: 0, max: 1000000000),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: style.colors['main1']!, width: 2))),
                initialValue: controller.minimumFollowers == '0'
                    ? ''
                    : controller.minimumFollowers,
                onChanged: (newVal) {
                  controller.setMinimumFollowers(newVal);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(controller.minimumFollowersString),
                ],
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: BigButton(
            function: () => Get.back(),
            title: '확인',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowerController>(
      tag: controllerTag,
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => openDialog(),
            style: ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(200, 50)),
                alignment: Alignment.centerRight),
            child: Text(
              controller.minimumFollowersString,
              style: style.textTheme.titleSmall?.copyWith(
                  color: style.colors['main1'],
                  fontWeight: FontWeight.bold,
                  height: 1.1),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
