import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../style.dart' as style;

class Header extends ConsumerStatefulWidget {
  const Header({super.key, this.header, this.headerTitle});

  final header;
  final headerTitle;

  @override
  HeaderState createState() => HeaderState();
}

final userController = Get.find<UserController>();

class HeaderState extends ConsumerState<Header> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      centerTitle: widget.header == 4 ? false : true,
      iconTheme: IconThemeData(color: Colors.black),
      leading: userController.memberType != 0
          ? widget.header == 0 || widget.header == 1
              ? IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu_outlined))
              : IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios_new_outlined))
          : widget.header == 3
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios_new_outlined))
              : Container(),
      title: widget.header == 0
          ? Image.asset(
              'assets/images/Clout_Logo.png',
              height: 22,
            )
          : widget.headerTitle != null
              ? Text(widget.headerTitle,
                  style: style.textTheme.titleSmall?.copyWith(
                      color: style.colors['text'],
                      fontWeight: FontWeight.w700,
                      height: 1))
              : null,
      actions: userController.memberType != 0
          ? widget.header != 3 && widget.header != 4
              ? [
                  IconButton(
                      onPressed: () => Get.toNamed('/notification'),
                      icon: Icon(Icons.notifications_outlined))
                ]
              : null
          : null,
    );
  }
}
