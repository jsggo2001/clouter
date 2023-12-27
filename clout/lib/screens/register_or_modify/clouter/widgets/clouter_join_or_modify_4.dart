import 'package:clout/providers/user_controllers/clouter_info_controller.dart';
import 'package:clout/widgets/pay_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;
import 'package:clout/screens/register_or_modify/clouter/widgets/category_toggle.dart';
import 'package:clout/widgets/region_multiselect.dart';

class ClouterJoinOrModify4 extends StatelessWidget {
  ClouterJoinOrModify4(
      {super.key, required this.modifying, required this.controllerTag});

  final modifying;
  final controllerTag;
  double percent = 1; // 초기값 설정

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClouterInfoController>(
      tag: controllerTag,
      builder: (controller) => FractionallySizedBox(
        widthFactor: 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              '4. 희망 광고 정보',
              style: style.textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '희망 광고비\n(최소 금액)',
                  style: style.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w500, height: 1.2),
                  textAlign: TextAlign.left,
                ),
                PayDialog(
                  title: '희망 광고비',
                  hintText: '희망 광고비 입력',
                  controllerTag: controllerTag,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '희망 카테고리',
              style: style.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500, height: 1.2),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 5),
            CategoryToggle(controllerTag: controllerTag),
            SizedBox(height: 20),
            Text(
              '희망 지역',
              style: style.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w500, height: 1.2),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 5),
            RegionMultiSelect(controllerTag: controllerTag),
            SizedBox(height: 8), //
          ],
        ),
      ),
    );
  }
}
