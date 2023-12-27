import 'package:clout/screens/find_password/find_complete.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';
import 'package:clout/widgets/input/input.dart';

class FindNewPassword extends StatefulWidget {
  const FindNewPassword({super.key});

  @override
  State<FindNewPassword> createState() => _FindNewPasswordState();
}

class _FindNewPasswordState extends State<FindNewPassword> {
  var password;
  var checkPassword;
  setPassword(input) {
    setState(() {
      password = input;
    });
  }

  setCheckPassword(input) {
    setState(() {
      checkPassword = input;
    });
  }

  setObscured() {
    setState(() {
      obscured = !obscured;
      print(obscured);
      if (obscured) {
        suffixIcon = Icon(Icons.visibility_outlined);
      } else {
        suffixIcon = Icon(Icons.visibility_off_outlined);
      }
    });
  }

  var obscured = true; // 예시 값
  Icon suffixIcon = Icon(Icons.visibility); // 예시 값
  var doubleId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 25, top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('새로운 비밀번호 만들고', style: style.textTheme.titleMedium),
            Row(
              children: <Widget>[
                Text('CLOUT',
                    style: style.textTheme.titleMedium
                        ?.copyWith(color: style.colors['main1'])),
                Text('와', style: style.textTheme.titleMedium),
              ],
            ),
            Text('함께 매칭해요', style: style.textTheme.titleMedium),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 25, bottom: 20),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Input(
                    placeholder: '패스워드 입력',
                    setText: setPassword,
                    obscure: obscured,
                    suffixIcon: suffixIcon,
                    setObscured: setObscured,
                  ),
                  SizedBox(height: 20),
                  Input(
                    placeholder: '패스워드 확인',
                    setText: setCheckPassword,
                    obscure: obscured,
                    suffixIcon: suffixIcon,
                  ),
                  SizedBox(height: 30),
                  BigButton(
                    title: '패스워드 설정',
                    function: () {
                      Get.to(() => FindComplete());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
