import 'dart:async';

import 'package:clout/providers/clouter_search_combination_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

class ClouterSearchBar extends StatelessWidget {
  final controllerTag;
  ClouterSearchBar({super.key, required this.controllerTag});

  Timer _timer = Timer(Duration(milliseconds: 2000), () {});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClouterSearchCombinationController>(
      tag: controllerTag,
      builder: (controller) => Padding(
        padding: EdgeInsets.all(15),
        child: TextField(
          onChanged: (value) {
            if (_timer.isActive) _timer.cancel();
            _timer = Timer(Duration(milliseconds: 500), () async {
              await controller.setSearchWord(value);
              await controller.fetchSearchResults();
              // await controller.setSearchWord('');
            });
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(15),
            hintText: "검색어를 입력하세요..",
            prefixIcon: Icon(
              Icons.search,
              size: 32,
              color: style.colors['main1'],
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Color(0xFF979C9E))),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(width: 3, color: Color(0xFF927EFF)),
            ),
          ),
        ),
      ),
    );
  }
}
