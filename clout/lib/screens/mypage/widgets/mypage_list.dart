import 'package:flutter/material.dart';

// widgets
import 'package:clout/screens/campaign_register/widgets/data_title.dart';
import 'package:clout/widgets/buttons/small_outlined_button.dart';

class MyPageList extends StatelessWidget {
  const MyPageList({
    super.key,
    required this.title,
    required this.btnTitle,
    required this.onButtonPressed,
  });

  final String title;
  final String btnTitle;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DataTitle(
              text: title,
            ),
            SmallOutlinedButton(title: btnTitle, onPressed: onButtonPressed,)
          ],
        ));
  }
}
