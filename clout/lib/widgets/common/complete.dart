import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// widgets
import 'package:clout/widgets/buttons/big_button.dart';

class CompletePage extends StatelessWidget {
  final String alertText;
  final String buttonText;
  final VoidCallback onPressed;
  final String pageName;

  CompletePage({
    required this.alertText,
    required this.buttonText,
    required this.onPressed,
    required this.pageName,
  });

  movePage() {
    Get.toNamed(pageName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.verified,
                    size: 120,
                    color: style.colors['main1'],
                  ),
                  SizedBox(height: 20),
                  Text(
                    alertText,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: BigButton(
                  title: buttonText,
                  function: movePage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
