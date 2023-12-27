import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// controllers
import 'package:clout/providers/clouter_search_combination_controller.dart';

class ClouterCategoryList extends StatefulWidget {
  ClouterCategoryList({super.key});

  @override
  State<ClouterCategoryList> createState() => _ClouterCategoryListState();
}

class _ClouterCategoryListState extends State<ClouterCategoryList> {
  final clouterSearchCombinationController =
      Get.put(ClouterSearchCombinationController(), tag: 'clouterList');

  @override
  build(BuildContext context) {
    final clouterSearchCombinationController =
        Get.find<ClouterSearchCombinationController>(tag: 'clouterList');

    double buttonSize = 50;
    clouterSearchCombinationController.setControllerTag('clouterList');
    clouterSearchCombinationController.runOtherControllers();
    return GetBuilder<ClouterSearchCombinationController>(
        tag: 'clouterList',
        builder: (controller) => Container(
              width: double.infinity,
              // height: 225,
              color: Color(0xffF6F4FF),
              padding: EdgeInsets.all(15),
              child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  runSpacing: 10,
                  children: _categoryButtons(context, 0, 11, buttonSize)),
            ));
  }

  List<Widget> _categoryButtons(
      BuildContext context, int startIndex, int lastIndex, double buttonSize) {
    final uniqueIndexes = List.generate(
        lastIndex - startIndex + 1, (index) => startIndex + index);

    final clouterSearchCombinationController =
        Get.find<ClouterSearchCombinationController>(tag: 'clouterList');

    return uniqueIndexes.map((index) {
      return Column(
        children: [
          _categoryButton(
            context,
            clouterSearchCombinationController.categoryData[index]['path']!,
            buttonSize,
            index,
          ),
          Text(clouterSearchCombinationController.categoryData[index]['name']!,
              style: TextStyle(
                fontWeight: FontWeight.w600,
              )),
        ],
      );
    }).toList();
  }

  Widget _categoryButton(
      BuildContext context, String imagePath, double buttonSize, int index) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final clouterSearchCombinationController =
        Get.find<ClouterSearchCombinationController>(tag: 'clouterList');

    bool isSelected =
        clouterSearchCombinationController.selectedCategories.contains(index);

    return InkWell(
      onTap: () {
        setState(() {
          if (index == 0) {
            clouterSearchCombinationController.selectedCategories.clear();
            clouterSearchCombinationController.selectedCategories.add(0);
          } else {
            clouterSearchCombinationController.selectedCategories.remove(0);
            if (clouterSearchCombinationController.selectedCategories
                .contains(index)) {
              clouterSearchCombinationController.selectedCategories
                  .remove(index);
            } else {
              clouterSearchCombinationController.selectedCategories.add(index);
            }
          }
          clouterSearchCombinationController.fetchSearchResults();
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          width: screenWidth / 7,
          height: screenWidth / 7,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          decoration: BoxDecoration(
            color: isSelected ? style.colors['main2'] : style.colors['white'],
            borderRadius: BorderRadius.circular(13),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              imagePath,
            ),
          ),
        ),
      ),
    );
  }
}
