// Global
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// Screen
import 'package:clout/screens/list/campaign/campaign_list.dart';
import 'package:clout/screens/list/clouter/clouter_list.dart';

class MenuTitle extends StatelessWidget {
  MenuTitle({super.key, this.text, this.destination});
  final text;
  final destination;
  move() {
    if (destination == 1) {
      Get.to(() => ClouterList());
    } else {
      Get.to(() => CampaignList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            text,
            style: style.textTheme.bodyLarge,
          ),
        ),
        IconButton(
            onPressed: () {
              move();
            },
            icon: Icon(Icons.keyboard_arrow_right_outlined))
      ],
    );
  }
}
