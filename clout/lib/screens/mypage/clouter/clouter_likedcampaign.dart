import 'package:clout/widgets/loading_indicator.dart';
import 'package:clout/widgets/refreshable_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// widgets
import 'package:clout/widgets/header/header.dart';
import 'package:clout/screens/list/widgets/campaign_infinite_scroll_body.dart';

// controllers
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:clout/providers/scroll_controllers/infinite_scroll_controller.dart';

class ClouterLikedCampaign extends GetView<InfiniteScrollController> {
  ClouterLikedCampaign({super.key});

  final infiniteController =
      Get.put(InfiniteScrollController(), tag: 'clouterLikedCampaign');
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    infiniteController.setCurrentPage(0);
    infiniteController.setEndPoint('/member-service/v1/bookmarks/ad');
    infiniteController.setParameter('?memberId=${userController.memberId}');
    final screenHeight = MediaQuery.of(context).size.height;
    infiniteController.reload();
    return GetBuilder<InfiniteScrollController>(
      tag: 'clouterLikedCampaign',
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 4,
            headerTitle: '관심있는 캠페인 목록',
          ),
        ),
        body: RefreshableContainer(
          controller: controller.scrollController.value,
          child: Column(
            children: [
              CampaignInfiniteScrollBody(controllerTag: 'clouterLikedCampaign'),
              infiniteController.isLoading
                  ? Column(
                      children: [
                        SizedBox(height: screenHeight / 3),
                        SizedBox(
                            height: 70, child: Center(child: LoadingWidget())),
                        SizedBox(height: 20),
                        Text(
                          '관심있는 캠페인을 불러오는 중입니다.\n잠시만 기다려 주세요.',
                          style: style.textTheme.headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
