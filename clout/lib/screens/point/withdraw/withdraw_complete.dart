import 'package:flutter/material.dart';

// widgets
import 'package:clout/widgets/common/complete.dart';

class WithdrawComplete extends StatelessWidget {
  const WithdrawComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return CompletePage(
      alertText: '출금 신청 완료!',
      buttonText: '포인트 내역으로 이동',
      onPressed: () {},
      pageName: "clouterpointlist",
    );
  }
}
