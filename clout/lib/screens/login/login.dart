// global
import 'package:clout/hooks/apis/login_api.dart';
import 'package:clout/hooks/apis/notification_token_api.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:clout/screens/find_password/find_password.dart';
import 'package:clout/screens/notification/widgets/get_mobile_id.dart';
import 'package:clout/screens/register_or_modify/widgets/join_input.dart';
import 'package:clout/type.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// widgets
import 'package:clout/widgets/buttons/big_button.dart';
import 'widgets/title_text.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var obscured = true;

  var suffixIcon = Icon(Icons.visibility_outlined);

  final userController = Get.find<UserController>();

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

  doLogin() async {
    // 유저가 맞는지 확인하는 api 통신 여기에 두고 맞으면 main으로 이동하게
    // Get.offAllNamed('/home');
    // // 1. 보냄
    // userController.setUserInfo(); // 'userInfo' 설정
    // final LoginApi loginApi = LoginApi();
    // var loginData = await loginApi.postRequest(
    //     '/v1/members/login', userController.userInfo);

    // 1. 보냄
    // userController.setUserInfo(); // 'userInfo' 설정
    final LoginApi loginApi = LoginApi();
    var loginData = await loginApi.postRequest(
        '/member-service/v1/members/login', LoginInfo(userId, password));
    // '/v1/members/login', userController.userInfo);

    // 2. 리턴값에서 유저/클라우터 가려받고 set
    if (loginData['login_success'] == true) {
      print('클라우트인지 광고주인지 : ${loginData}');
      if (loginData['memberRole'] == 'ADVERTISER') {
        //광고주 1
        userController.setAdvertiser();
        print('광고주 쪽으로 넘어옴');
      } else {
        //클라우터 -1
        userController.setClouter();
        print('클라우터 쪽으로 넘어옴');
      }
      userController.setUserLogin(loginData);
      userController.setMemberId(loginData['memberId']);
      print('여기');
      print(userController.userLogin);

      //-----------------------------------------
      //여기에서 알람 post 하기 💥 주석해야 로그인 성공 후 홈으로 넘어감... 나중에 주석 풀기
      final token = await FirebaseMessaging.instance.getToken();
      // final String mobileId = await getMobileId();
      // var notiParam = {
      //   'memberId': userController.memberId,
      //   'deviceId':mobileId,
      //   'fcmToken':token,
      // };

      // //memberId, deviceId, fcmToken
      // final NotificationTokenApi notificationTokenApi = NotificationTokenApi();
      // var notiData = await notificationTokenApi.postRequest(
      //   '/notification-service/v1/notifications/members/token-check',
      //   notiParam);

      // print(notiData);

      //홈으로
      Get.offAllNamed('/home');
    }
  }

  var userId;
  var password;

  void setId(input) {
    setState(() {
      userId = input;
    });
  }

  void setPassword(input) {
    setState(() {
      password = input;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 상단 글자 Column
          Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(text: '로그인해서'),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/Clout_Logo.png',
                            width: 100,
                          ),
                          TitleText(
                            text: ' 와 함께',
                          )
                        ],
                      ),
                      TitleText(text: '매칭해요')
                    ]),
              )),
          // 중간 Input Column
          Flexible(
              flex: 4,
              child: FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      JoinInput(
                        keyboardType: TextInputType.text,
                        maxLength: 15,
                        title: '아이디 입력',
                        label: '아이디',
                        setState: setId,
                        enabled: true,
                      ),
                      SizedBox(height: 15),
                      Stack(
                        children: [
                          JoinInput(
                            keyboardType: TextInputType.text,
                            maxLength: 20,
                            title: '비밀번호 입력',
                            label: '비밀번호',
                            setState: setPassword,
                            obscured: obscured,
                            enabled: true,
                          ),
                          Positioned(
                            top: 3,
                            right: 5,
                            child: IconButton(
                              onPressed: setObscured,
                              icon: obscured
                                  ? Icon(
                                      Icons.visibility_outlined,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      Icons.visibility_off_outlined,
                                      color: Colors.grey,
                                    ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        // width: double.infinity,
                        height: 25,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              Get.to(FindPassword());
                            },
                            child: Text('패스워드가 기억이 안나요',
                                style: style.textTheme.bodyMedium?.copyWith(
                                    color: style.colors['gray'], height: 2))),
                      ),
                      // 로그인 버튼
                      // destination 수정해서 로그인 실행하는 로직 넣어야 함
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: BigButton(
                            title: '로그인',
                            function: doLogin,
                          ),
                        ),
                      ),
                    ],
                  ))),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('계정이 아직 없다면?',
                    style: style.textTheme.bodyLarge
                        ?.copyWith(color: style.colors['gray'])),
                TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () => {Get.toNamed('/join')},
                    child: Text(' 회원가입하기',
                        style: style.textTheme.bodyLarge?.copyWith(
                            color: style.colors['main1'],
                            fontWeight: FontWeight.w700)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
