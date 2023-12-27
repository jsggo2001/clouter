import 'package:clout/providers/age_controller.dart';
import 'package:clout/providers/fee_controller.dart';
import 'package:clout/providers/follower_controller.dart';
import 'package:clout/providers/platform_select_controller.dart';
import 'package:clout/providers/region_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  int tab = 0;

  void setTab(tabIndex) {
    tab = tabIndex;
    update();
  }

}
