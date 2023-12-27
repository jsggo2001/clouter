import 'dart:async';

import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

// widgets
import 'package:clout/widgets/sns/platform_toggle.dart';
import 'package:clout/widgets/age_slider.dart';
import 'package:clout/widgets/region_multiselect.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/search_detail_bottom_sheet/widgets/fee_range_dialog.dart';
import 'package:clout/widgets/search_detail_bottom_sheet/widgets/follower_count_dialog.dart';

// controllers
import 'package:clout/providers/search_detail_controller.dart';

// utilties
import 'package:clout/utilities/bouncing_listview.dart';

// Screens
import 'package:clout/widgets/list/data_title_thin.dart';
import 'package:get/get.dart';

class SearchDetailButton extends StatelessWidget {
  SearchDetailButton({super.key});

  final searchController = Get.put(
    SearchDetailController(),
    tag: 'searchDetail',
  );

  void openBottomSheet() {
    Get.bottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      Container(
        color: Colors.white,
        height: 700,
        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('상세 조건 설정',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    )),
                InkWell(
                  child: Icon(
                    Icons.close,
                  ),
                  onTap: () {
                    Get.back();
                  },
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 520,
              decoration: BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                ),
              ),
              // padding: EdgeInsets.only(top: 5, bottom: 5),
              child: BouncingListview(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DataTitleThin(text: '희망 광고 플랫폼'),
                        Text('다중 선택 가능',
                            style: TextStyle(color: style.colors['gray']))
                      ],
                    ),
                    SizedBox(height: 10),
                    PlatformToggle(
                        multiAllowed: true, controllerTag: 'searchDetail'),
                    ///////////////////////////////////////////
                    SizedBox(height: 20),
                    DataTitleThin(text: '희망 클라우터 나이'),
                    // slider 추가
                    AgeSlider(controllerTag: 'searchDetail'),
                    // ///////////////////////////////////////////
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        DataTitleThin(text: '희망 최소 팔로워 수'),
                        Text('최대 10억',
                            style: TextStyle(color: style.colors['gray']))
                      ],
                    ),
                    FollowerCountDialog(
                        controllerTag: 'searchDetail',
                        title: '희망 최소 팔로워수',
                        hintText: '희망 최소 팔로워 수(최대 10억)'),
                    ///////////////////////////////////////////
                    DataTitleThin(text: '희망 광고비'),
                    SizedBox(height: 10),
                    FeeRangeDialog(controllerTag: 'searchDetail'),
                    ///////////////////////////////////////////
                    SizedBox(height: 20),
                    DataTitleThin(text: '지역 선택'),
                    SizedBox(height: 10),
                    RegionMultiSelect(controllerTag: 'searchDetail'),
                  ],
                ),
              ),
            ),
            ///////////////////////////////////////////
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: BigButton(
                  title: '검색',
                  function: () {
                    Get.back();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchDetailController>(
      tag: 'searchDetail',
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.end, // 가장 오른쪽으로 정렬
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(children: [
                Text(
                  '검색 조건 설정',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: style.colors['main1']),
                ),
                Icon(Icons.chevron_right,
                    size: 20, color: style.colors['main1']),
              ]),
            ),
            onTap: () {
              openBottomSheet();
            },
          ),
        ],
      ),
    );
  }
}
