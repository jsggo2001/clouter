import 'package:clout/providers/user_controllers/clouter_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

class Category {
  final String name;
  final String title;

  Category(this.name, this.title);
}

final List<Category> imgList = [
  Category('all', '전체'),
  Category('cosmetics', '패션/뷰티'),
  Category('barbell', '건강/생활'),
  Category('airplane', '여행/레저'),
  Category('baby', '육아'),
  Category('electronics', '전자제품'),
  Category('food', '음식'),
  Category('location', '방문/체험'),
  Category('paw', '반려동물'),
  Category('game', '게임'),
  Category('money', '경제/사업'),
  Category('more', '기타')
];

class CategoryToggle extends StatelessWidget {
  const CategoryToggle({super.key, required this.controllerTag});

  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClouterInfoController>(
      tag: controllerTag,
      builder: (controller) => Center(
        child: Wrap(
          children: List.generate(3, (rowIndex) {
            return ToggleButtons(
              onPressed: (int innerIndex) {
                final currentIndex = rowIndex * 4 + innerIndex;
                controller.setSelection(currentIndex);
              },
              color: Colors.white,
              borderColor: Colors.white,
              selectedBorderColor: Colors.white,
              fillColor: Colors.white,
              splashColor: Colors.white,
              borderWidth: 0,
              isSelected: controller.selections
                  .sublist(rowIndex * 4, (rowIndex + 1) * 4),
              children: List.generate(4, (innerIndex) {
                final currentIndex = rowIndex * 4 + innerIndex;
                return Container(
                  width: 80,
                  height: 90,
                  decoration: BoxDecoration(
                      color: controller.selections[currentIndex]
                          ? style.colors['main2']
                          : Color(0xFFE8ECF4),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3, color: Colors.white)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(
                            'assets/images/${imgList[currentIndex].name}.png',
                            height: 50,
                            fit: BoxFit.fitHeight),
                        Text(
                          imgList[currentIndex].title,
                          style: style.textTheme.bodySmall
                              ?.copyWith(color: style.colors['text']),
                        )
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
