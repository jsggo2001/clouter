import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:get/get.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController(), permanent: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 130, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '광고주와 인플루언서',
                          style: style.textTheme.titleSmall?.copyWith(
                            color: style.colors['darkgray'],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '매칭부터 계약서 작성까지',
                          style: style.textTheme.titleSmall?.copyWith(
                            color: style.colors['darkgray'],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/Clout_Logo.png',
                            height: 40,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Image.asset('assets/images/landingPage.jpeg')
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                // heightFactor: 1.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: BigButton(
                        title: '로그인',
                        function: () => Get.offNamed('/login'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () => Get.toNamed('/join'),
                          child: Text(
                            '회원가입',
                            style: style.textTheme.headlineSmall?.copyWith(
                                color: style.colors['main1'],
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text('|'),
                        TextButton(
                          onPressed: () => Get.toNamed('/home'),
                          child: Text(
                            '둘러보기',
                            style: style.textTheme.headlineSmall?.copyWith(
                                color: style.colors['main1'],
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
