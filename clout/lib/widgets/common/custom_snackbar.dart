import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

class CustomSnackbar {
  final String title;
  final String message1;
  final String message2;

  CustomSnackbar(
      {required this.title, required this.message1, required this.message2});

  show() {
    Get.snackbar(
      '',
      '',
      duration: Duration(seconds: 4),
      titleText: Text(
        title,
        style: style.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message1,
            style: style.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            message2,
            style: style.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      borderWidth: 5,
      borderColor: style.colors['main1'],
      margin: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
      ),
    );
  }
}
