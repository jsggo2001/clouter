import 'package:clout/screens/find_password/widgets/jobToggle.dart';
import 'package:clout/screens/register_or_modify/widgets/number_verify.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/widgets/input/input.dart';
import 'package:clout/style.dart' as style;

class FindPassword extends StatefulWidget {
  const FindPassword({super.key});

  @override
  FindPasswordState createState() => FindPasswordState();
}

class FindPasswordState extends State<FindPassword> {
  var userId;
  var phoneNumber;
  setUserId(input) {
    setState(() {
      userId = input;
    });
  }
  setNumber(input) {
    setState(() {
      phoneNumber = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('비밀번호 찾고', style: style.textTheme.titleMedium),
            Row(
              children: <Widget>[
                Text('CLOUT',
                    style: style.textTheme.titleMedium
                        ?.copyWith(color: style.colors['main1'])),
                Text('와 함께', style: style.textTheme.titleMedium),
              ],
            ),
            Text('매칭해요', style: style.textTheme.titleMedium),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 25, bottom: 20),
              child: Column(
                children: [
                  // JobToggle(),
                  SizedBox(height: 20),
                   Input(
                    placeholder: '아이디 입력',
                    setText: setUserId
                  ),
                  SizedBox(height: 20),
                  Input(
                    placeholder: '전화번호 입력',
                    setText: setNumber,
                  ),
                  SizedBox(height: 40),
                  BigButton(
                      title: '코드 전송',
                      function: () {
                        // Get.to(NumberVerify(phoneNumber: phoneNumber, controllerTag: controllerTag));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
