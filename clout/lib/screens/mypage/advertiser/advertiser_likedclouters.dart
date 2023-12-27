import 'package:clout/widgets/loading_indicator.dart';
import 'package:clout/widgets/refreshable_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// screens
import 'package:clout/screens/list/widgets/clouter_infinite_scroll_body.dart';

// widgets
import 'package:clout/widgets/header/header.dart';

// controllers
import 'package:clout/providers/scroll_controllers/clouter_infinite_scroll_controller.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';

class AdvertiserLikedclouters extends GetView<ClouterInfiniteScrollController> {
  AdvertiserLikedclouters({super.key});

  final infiniteController = Get.put(ClouterInfiniteScrollController(),
      tag: 'advertiserLikedClouters');

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    infiniteController.setCurrentPage(0);
    infiniteController.setEndPoint('/member-service/v1/bookmarks/clouter');
    infiniteController.setParameter(
        '?page=${infiniteController.currentPage}&size=${10}&memberId=${userController.memberId}');
    final screenHeight = MediaQuery.of(context).size.height;
    infiniteController.reload();
    return GetBuilder<ClouterInfiniteScrollController>(
      tag: 'advertiserLikedClouters',
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 4,
            headerTitle: '관심있는 클라우터 목록',
          ),
        ),
        body: RefreshableContainer(
          controller: controller.scrollController.value,
          child: Column(
            children: [
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
                                    '좋아요 누른 클라우터가 없어요 😢',
                                    style: style.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                            : ClouterInfiniteScrollBody(
                                controllerTag: 'advertiserLikedClouters'),
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
                          '좋아요 누른 클라우터를 불러오는 중입니다.\n잠시만 기다려 주세요.',
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
