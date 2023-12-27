import 'package:clout/type.dart';
import 'package:clout/widgets/input/input_elements/input_element.dart';
import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  CategoryDropdown({super.key, this.category, this.setCategory});

  final category;
  final setCategory;

  var categories = [
    Category('ALL', '전체'),
    Category('FASHION_BEAUTY', '패션/뷰티'),
    Category('HEALTH_LIFESTYLE', '건강/생활'),
    Category('TRAVEL_LEISURE', '여행/레저'),
    Category('PARENTING', '육아'),
    Category('ELECTRONICS', '전자제품'),
    Category('FOOD', '음식'),
    Category('VISIT_EXPERIENCE', '방문/체험'),
    Category('PETS', '반려동물'),
    Category('GAMES', '게임'),
    Category('ECONOMY_BUSINESS', '경제/비즈니스'),
    Category('OTHERS', '기타')
  ];

  @override
  Widget build(BuildContext context) {
    return InputElement(
      elementType: 'dropdown',
      data: categories,
      value: category,
      placeholder: '카테고리 선택',
      setData: setCategory,
    );
  }
}
