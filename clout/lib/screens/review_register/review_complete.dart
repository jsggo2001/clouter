import 'package:flutter/material.dart';
import 'package:clout/style.dart';

// widgets
import 'package:clout/widgets/common/complete.dart';

class ReviewComplete extends StatelessWidget {
  const ReviewComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return CompletePage(
      alertText: '리뷰 작성 완료!',
      buttonText: '홈으로 이동',
      onPressed: () {},
      pageName: "home",
    );
  }
}
