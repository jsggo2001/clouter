import 'package:clout/providers/region_controller.dart';
import 'package:clout/screens/campaign_register/widgets/data_title.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/buttons/small_button.dart';
import 'package:clout/widgets/region_multiselect_chip.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class RegionMultiSelect extends StatefulWidget {
  RegionMultiSelect({super.key, required this.controllerTag});
  final controllerTag;
  static List<String> regions = [
    '전체',
    '서울',
    '부산',
    '대구',
    '인천',
    '광주',
    '대전',
    '울산',
    '세종',
    '경기',
    '강원',
    '충북',
    '충남',
    '전북',
    '전남',
    '경북',
    '경남',
    '제주',
  ];

  @override
  State<RegionMultiSelect> createState() => _RegionMultiSelectState();
}

class _RegionMultiSelectState extends State<RegionMultiSelect> {
  void showBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return GetBuilder<RegionController>(
          tag: widget.controllerTag,
          builder: (controller) {
            return SizedBox(
              height: 600,
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 30.0, bottom: 10.0),
                      child: Text(
                        '지역 선택',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Jost',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 450,
                      padding: EdgeInsets.only(bottom: 20),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: List.generate(
                          18,
                          (index) => CheckboxListTile(
                            title: Text(
                                controller.regionsSelectedBool[index].region),
                            onChanged: (value) =>
                                {controller.setSelectDeselect(index)},
                            value:
                                controller.regionsSelectedBool[index].selected,
                            activeColor: style.colors['main1'],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: BigButton(
                        title: '확인',
                        function: () => Get.back(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegionController>(
      tag: widget.controllerTag,
      builder: (controller) => Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: style.colors['gray']!),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: style.colors['white'],
                padding: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    side: BorderSide.none),
                elevation: 0,
              ),
              onPressed: showBottomSheet,
              child: ListTile(
                leading: Icon(Icons.place_outlined, size: 40),
                contentPadding: EdgeInsets.all(0),
                title: Text('여러 지역 선택 가능'),
                subtitle: Text('항목 터치시 삭제'),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 80,
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              // color: Colors.amber,
              border: Border(
                top: BorderSide(width: 0, color: Colors.grey),
                left: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
                right: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
                bottom: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('     선택 지역 목록'),
                BouncingListview(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: controller.selectedRegions
                          .map(
                            (e) => RegionMultiselectChip(
                              title: e,
                              controllerTag: widget.controllerTag,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
