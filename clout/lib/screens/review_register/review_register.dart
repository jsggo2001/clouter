import 'package:clout/widgets/buttons/big_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// Widgets
import 'package:clout/widgets/header/header.dart';
import 'package:clout/screens/review_register/widgets/information_box.dart';
import 'package:clout/screens/review_register/widgets/star_rating.dart';
import 'package:clout/screens/review_register/review_complete.dart';

class ReviewRegister extends StatefulWidget {
  const ReviewRegister({super.key});

  @override
  State<ReviewRegister> createState() => _ReviewRegisterState();
}

class _ReviewRegisterState extends State<ReviewRegister> {
  int maxRating = 5; // 최대 점수 (별 개수)
  int initialRating = 0; // 초기 점수
  int userRating = 0; // 사용자의 평가 점수

  doRegister() {
    Get.toNamed('/reviewcomplete');
  }

  void onRatingChanged(int rating) {
    // 별점이 변경될 때 호출되는 함수
    setState(() {
      userRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.colors['white'],
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 4,
            headerTitle: '',
          )),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('이번 계약은 어떠셨나요?',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      )),
                  Text('만족스러우셨다면', style: TextStyle(fontSize: 17)),
                  Text('좋은 평가를 남겨주세요!', style: TextStyle(fontSize: 17)),
                ],
              )),
          InformationBox(),
          StarRating(
            maxRating: maxRating,
            initialRating: initialRating,
            onRatingChanged: onRatingChanged,
          ),
        ]),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
        child: BigButton(title: '완료', function: doRegister),
      ),
    );
  }
}
