import 'package:clout/widgets/input/input_elements/input_element.dart';
import 'package:flutter/material.dart';

class ProductTextinput extends StatelessWidget {
  ProductTextinput({super.key, this.setProductName});
  final setProductName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        child: InputElement(
          elementType: 'text',
          placeholder: '캠페인 제목 입력',
          setData: setProductName,
          maxLength: 50,
        ));
  }
}
