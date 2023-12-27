import 'package:clout/providers/scroll_controllers/select_infinite_scroll_controller.dart';
import 'package:clout/screens/list/widgets/select_infinite_scroll_body.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

// widgets
import 'package:clout/screens/point/withdraw/widgets/bold_text.dart';
import 'package:clout/screens/detail/clouter/widgets/medium_text.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/header/header.dart';
import 'package:get/get.dart';

class ClouterSelect extends StatelessWidget {
  ClouterSelect({super.key});

  final SelectInfiniteScrollController selectInfiniteController =
      Get.put(SelectInfiniteScrollController(), tag: 'clouterSelect');

  @override
  Widget build(BuildContext context) {
    /////////////////////////////////////////////////////
    selectInfiniteController.setParameter(
        '?advertisementId=${selectInfiniteController.campaignId}&page=${selectInfiniteController.currentPage}&size=${10}');
    /////////////////////////////////////////////////////

    return GetBuilder<SelectInfiniteScrollController>(
      tag: 'clouterSelect',
      builder: (controller) => Scaffold(
        backgroundColor: style.colors['white'],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 4,
            headerTitle: '클라우터 채택',
          ),
        ),
        body: BouncingListview(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.filter_list, size: 20),
                  Text(' 정렬'),
                ],
              ),
              SelectInfiniteScrollBody(controller: selectInfiniteController),
            ],
          ),
        )),
        bottomSheet: Container(
          height: 110,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: style.colors['category']!,
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MediumText(text: '전체 지원자'),
                    BoldText(
                        text:
                            '${selectInfiniteController.numberOfApplicants}명'),
                  ],
                ),
              ),
              VerticalDivider(
                color: style.colors['lightgray'],
                thickness: 1,
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MediumText(text: '채택 인원'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            '${selectInfiniteController.numberOfSelectedMembers}명',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: style.colors['main1'])),
                        BoldText(
                            text:
                                ' / ${selectInfiniteController.numberOfRecruiter}명')
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
