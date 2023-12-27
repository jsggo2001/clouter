import 'dart:async';

import 'package:clout/providers/scroll_controllers/infinite_scroll_controller.dart';
import 'package:clout/providers/search_detail_controller.dart';
import 'package:clout/utilities/category_translator.dart';
import 'package:get/get.dart';

class SearchCombinationController extends GetxController {
  var controllerTag;

  var searchWord = '';

  var selectedCategories = [0];

  var categoryQueryString = '';

// 필요한 controller들
  var searchDetailController;
  var infiniteController;
// 필요한 controller들 실행시키는 메소드
  runOtherControllers() {
    searchDetailController = Get.put(SearchDetailController());
    infiniteController = Get.find<InfiniteScrollController>(tag: controllerTag);
  }

  setControllerTag(input) {
    controllerTag = input;
    // update();
  }

  setSearchWord(input) {
    searchWord = input;
    update();
  }

  setSelectedCategories(input) {
    selectedCategories = input;
    update();
  }

  setCategoryQueryString(input) {
    categoryQueryString = input;
    update();
  }

  fetchSearchResults() {
    String categoryQueryString;

    if (selectedCategories.contains(0)) {
      categoryQueryString = "category=ALL";
    } else {
      categoryQueryString = selectedCategories
          .map((index) =>
              "category=${AdCategoryTranslator.translateSearchCategory(categoryData[index]['name']!)}")
          .join('&');
    }
    final String requestUrl =
        '$categoryQueryString${searchDetailController.getSearchUrl()}&sortKey=POPULARITY&keyword=$searchWord';

    infiniteController.setParameter(requestUrl);
    infiniteController.reload();
  }

//// 기타 등등
  final List<Map<String, String>> categoryData = [
    {'path': 'assets/images/all.png', 'name': '전체보기'},
    {'path': 'assets/images/cosmetics.png', 'name': '패션/뷰티'},
    {'path': 'assets/images/barbell.png', 'name': '건강/생활'},
    {'path': 'assets/images/airplane.png', 'name': '여행/레저'},
    {'path': 'assets/images/baby.png', 'name': '육아'},
    {'path': 'assets/images/electronics.png', 'name': '전자제품'},
    {'path': 'assets/images/food.png', 'name': '음식'},
    {'path': 'assets/images/location.png', 'name': '방문/체험'},
    {'path': 'assets/images/paw.png', 'name': '반려동물'},
    {'path': 'assets/images/game.png', 'name': '게임'},
    {'path': 'assets/images/money.png', 'name': '경제/사업'},
    {'path': 'assets/images/more.png', 'name': '기타'},
  ];
}
