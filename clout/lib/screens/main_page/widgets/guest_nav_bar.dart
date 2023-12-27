import 'package:clout/widgets/buttons/big_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

class GuestNavBar extends StatelessWidget {
  const GuestNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'CLOUT의 더 많은 기능을 누려보세요!',
            style: style.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: BigButton(
              function: () => Get.offNamed('/join'),
              title: 'CLOUT 가입하러 가기',
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
