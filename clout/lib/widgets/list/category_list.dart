import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// controllers
import 'package:clout/providers/search_combination_controller.dart';

class CategoryList extends StatefulWidget {
  CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  final searchCombinationController =
      Get.put(SearchCombinationController(), tag: 'campaignList');

  @override
  build(BuildContext context) {
    final searchCombinationController =
        Get.find<SearchCombinationController>(tag: 'campaignList');

    double buttonSize = 50;
    searchCombinationController.setControllerTag('campaignList');
    searchCombinationController.runOtherControllers();
    return GetBuilder<SearchCombinationController>(
        tag: 'campaignList',
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

    final searchCombinationController =
        Get.find<SearchCombinationController>(tag: 'campaignList');

    return uniqueIndexes.map((index) {
      return Column(
        children: [
          _categoryButton(
            context,
            searchCombinationController.categoryData[index]['path']!,
            buttonSize,
            index,
          ),
          Text(searchCombinationController.categoryData[index]['name']!,
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

    final searchCombinationController =
        Get.find<SearchCombinationController>(tag: 'campaignList');

    bool isSelected =
        searchCombinationController.selectedCategories.contains(index);

    return InkWell(
      onTap: () {
        setState(() {
          if (index == 0) {
            searchCombinationController.selectedCategories.clear();
            searchCombinationController.selectedCategories.add(0);
          } else {
            searchCombinationController.selectedCategories.remove(0);
            if (searchCombinationController.selectedCategories
                .contains(index)) {
              searchCombinationController.selectedCategories.remove(index);
            } else {
              searchCombinationController.selectedCategories.add(index);
            }
          }
          searchCombinationController.fetchSearchResults();
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
