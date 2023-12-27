import 'package:clout/widgets/input/input_elements/input_element.dart';
import 'package:flutter/material.dart';

class BankDropdown extends StatelessWidget {
  BankDropdown({super.key, this.bank, this.setBank});

  final bank;
  final setBank;

  var banks = [
    '경남은행',
    '광주은행',
    '국민은행',
    '기업은행',
    '농협중앙회',
    '지역농협·축협',
    '대구은행',
    '대신저축은행',
    '도이치은행',
    '모건스탠리은행',
    '미쓰비시은행',
    '부산은행',
    '산림조합중앙회',
    '산업은행',
    '상호저축은행',
    '새마을금고',
    '수협',
    '씨티은행',
    '신한은행',
    '신협',
    '아메리카은행',
    '외환은행',
    '우리은행',
    '우체국',
    '웰컴저축은행',
    '전북은행',
    '제이피모던체이스은행',
    '제주은행',
    '카카오뱅크',
    '케이뱅크',
    '하나은행',
    '한국수출입은행',
    '한국은행',
    'HSBC',
    'SC제일은행',
  ];

  @override
  Widget build(BuildContext context) {
    return InputElement(
      elementType: 'dropdownunder',
      data: banks,
      value: bank,
      placeholder: '-- 은행명 선택 --',
      setData: setBank,
    );
  }
}
