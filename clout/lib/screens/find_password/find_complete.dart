import 'package:flutter/material.dart';
import 'package:clout/widgets/common/complete.dart';
import 'package:get/get.dart';

class FindComplete extends StatelessWidget {
  const FindComplete({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CompletePage(
        alertText: '비밀번호 변경 성공!',
        buttonText: '로그인으로 돌아가기',
        onPressed: () {
          Get.toNamed('/login');
        },
        pageName: "findcomplete",
      ),
    );
  }
}
