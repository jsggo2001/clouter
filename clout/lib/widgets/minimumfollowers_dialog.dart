import 'package:clout/providers/follower_controller.dart';
import 'package:clout/screens/campaign_register/widgets/data_title.dart';
import 'package:clout/hooks/numeric_range_formatter.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MinimumfollowersDialog extends StatelessWidget {
  MinimumfollowersDialog({super.key, required this.controllerTag});
  final controllerTag;

  openMinFollowerDialog() {
    Get.defaultDialog(
      title: '희망 최소 팔로워 수',
      titlePadding: EdgeInsets.only(top: 30),
      contentPadding: EdgeInsets.fromLTRB(40, 10, 40, 30),
      actions: [
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: style.colors['main1']),
            child: Text("확인"),
          ),
        ),
      ],
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
                    hintText: '희망 최소 팔로워수(최대 10억)',
                    contentPadding: EdgeInsets.only(left: 0, right: 0),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowerController>(
      tag: controllerTag,
      builder: (controller) => SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => openMinFollowerDialog(),
              child: Text(
                controller.minimumFollowersString,
                style: style.textTheme.titleMedium?.copyWith(
                    color: style.colors['main1'],
                    fontWeight: FontWeight.bold,
                    height: 1.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
