import 'package:flutter/material.dart';
import 'package:get/get.dart';

// controllers
import 'package:clout/providers/user_controllers/user_controller.dart';

// widgets
import 'package:clout/widgets/common/complete.dart';

class AddComplete extends StatelessWidget {
  const AddComplete({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return CompletePage(
        alertText: '포인트 충전 완료!',
        buttonText: '포인트 내역으로 이동',
        onPressed: () {},
        pageName: userController.memberType == 1
            ? "advertiserpointlist"
            : "clouterpointlist");
  }
}
