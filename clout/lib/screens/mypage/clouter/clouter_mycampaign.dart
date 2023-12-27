import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// widgets
import 'package:clout/widgets/header/header.dart';
import 'package:clout/widgets/loading_indicator.dart';
import 'package:clout/screens/list/widgets/campaign_infinite_scroll_body.dart';
import 'package:clout/widgets/common/choicechip.dart';
import 'package:clout/widgets/refreshable_container.dart';

// controllers
import 'package:clout/providers/scroll_controllers/infinite_scroll_controller.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';

class ClouterMyCampaign extends GetView<InfiniteScrollController> {
  ClouterMyCampaign({super.key});

  final infiniteController =
      Get.put(InfiniteScrollController(), tag: 'clouterMyCampaign');

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    infiniteController.setCurrentPage(0);
    infiniteController
        .setEndPoint('/advertisement-service/v1/applies/clouters');
    infiniteController.setParameter(
        '?clouterId=${userController.memberId}&type=${infiniteController.typeParam}&page=${infiniteController.currentPage}&size=${10}');
    final screenHeight = MediaQuery.of(context).size.height;

    infiniteController.reload();
    return GetBuilder<InfiniteScrollController>(
      tag: 'clouterMyCampaign',
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 4,
            headerTitle: '신청한 캠페인',
          ),
        ),
        body: RefreshableContainer(
          controller: controller.scrollController.value,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ActionChoiceExample(
                  labels: ['대기중', '채택된 캠페인', '미채택된 캠페인', '신청 취소'],
                  chipCount: 4,
                  onChipSelected: (label) {
                    String typeParam = '';
                    switch (label) {
                      case '대기중':
                        typeParam = 'WAITING';
                        break;
                      case '채택된 캠페인':
                        typeParam = 'ACCEPTED';
                        break;
                      case '미채택된 캠페인':
                        typeParam = 'NOT_ACCEPTED';
                        break;
                      case '신청 취소':
                        typeParam = 'CANCEL';
                        break;
                    }
                    print('Selected typeParam: $typeParam');
                    infiniteController.setTypeParam(typeParam);
                    print(
                        'Updated typeParam in controller: ${infiniteController.typeParam}');
                    infiniteController.setParameter(
                        '?clouterId=${userController.memberId}&type=${infiniteController.typeParam}&page=${infiniteController.currentPage}&size=${10}');
                    print(
                        'Updated parameter in controller: ${infiniteController.parameter}');
                    infiniteController.reload();
                  },
                ),
              ),
              !controller.isLoading
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        controller.data.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(height: 50),
                                  Image.asset(
                                    'assets/images/empty_campaign.png',
                                    width: 70,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '신청한 캠페인이 없어요 😢',
                                    style: style.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                            : CampaignInfiniteScrollBody(
                                controllerTag: 'clouterMyCampaign'),
                        controller.dataLoading && controller.hasMore
                            ? Column(
                                children: [
                                  SizedBox(height: 20),
                                  SizedBox(
                                      height: 70,
                                      child: Center(child: LoadingWidget())),
                                ],
                              )
                            : SizedBox(height: 100)
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: screenHeight / 4),
                        SizedBox(
                            height: 70, child: Center(child: LoadingWidget())),
                        SizedBox(height: 20),
                        Text(
                          '내 캠페인을 불러오는 중입니다.\n잠시만 기다려 주세요.',
                          style: style.textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
