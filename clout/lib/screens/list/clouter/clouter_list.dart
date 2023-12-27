import 'package:clout/widgets/input/clouter_search_bar.dart';
import 'package:clout/widgets/list/clouter_category_list.dart';
import 'package:clout/widgets/search_detail_bottom_sheet/search_detail_button.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// controllers
import 'package:clout/providers/scroll_controllers/clouter_infinite_scroll_controller.dart';
import 'package:clout/providers/clouter_search_combination_controller.dart';

// widgets
import 'package:clout/screens/list/widgets/clouter_infinite_scroll_body.dart';
import 'package:clout/widgets/header/header.dart';
import 'package:clout/widgets/common/main_drawer.dart';
import 'package:clout/widgets/loading_indicator.dart';
import 'package:clout/widgets/refreshable_container.dart';

String translateAdCategory(int adCategory) {
  Map<int, String> adCategoryTranslations = {
    0: "전체보기",
    1: "패션/뷰티",
    2: "건강/생활",
    3: "여행/레저",
    4: "육아",
    5: "전자제품",
    6: "음식",
    7: "방문/체험",
    8: "반려동물",
    9: "게임",
    10: "경제/사업",
    11: "기타",
  };

  return adCategoryTranslations[adCategory] ?? "";
}

class ClouterList extends GetView<ClouterInfiniteScrollController> {
  ClouterList({super.key});

  final infiniteController =
      Get.put(ClouterInfiniteScrollController(), tag: 'clouterList');

  final clouterSearchCombinationController =
      Get.put(ClouterSearchCombinationController(), tag: 'clouterList');

  @override
  Widget build(BuildContext context) {
    /////////////////////////////////////////////////////
    infiniteController.setCurrentPage(0);
    infiniteController.setEndPoint(
        '/member-service/v1/clouters/search?page=${infiniteController.currentPage}&size=${10}&');
    // infiniteController.setParameter(
    //     '/search?page=${infiniteController.currentPage}&size=${10}');
    final screenHeight = MediaQuery.of(context).size.height;
    infiniteController.reload();
    /////////////////////////////////////////////////////
    return GetBuilder<ClouterInfiniteScrollController>(
      tag: 'clouterList',
      builder: (controller) => Scaffold(
        drawer: MyDrawer(),
        backgroundColor: style.colors['white'],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 1,
            headerTitle: '클라우터 목록',
          ),
        ),
        body: RefreshableContainer(
          controller: controller.scrollController.value,
          child: Column(
            children: [
              ClouterSearchBar(
                controllerTag: 'clouterList',
              ),
              ClouterCategoryList(),
              SearchDetailButton(),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      clouterSearchCombinationController.selectedCategories
                          .map((index) => translateAdCategory(index))
                          .join(', '),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              !controller.isLoading
                  ? Column(
                      children: [
                        SizedBox(height: 20),
                        controller.data.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(height: 50),
                                  Image.asset(
                                    'assets/images/empty_clouter.png',
                                    width: 70,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    '아직 등록된 클라우터가 없어요.. 😢',
                                    style: style.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              )
                            : ClouterInfiniteScrollBody(
                                controllerTag: 'clouterList'),
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
                          '클라우터를 불러오는 중입니다.\n잠시만 기다려 주세요.',
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
