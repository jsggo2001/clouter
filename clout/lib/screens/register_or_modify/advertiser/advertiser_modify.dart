import 'dart:convert';

import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/hooks/apis/login_api.dart';
import 'package:clout/providers/user_controllers/advertiser_controller.dart';
import 'package:clout/providers/user_controllers/advertiser_info_controller.dart';
import 'package:clout/screens/profile/advertiser/advertiser_profile.dart';
import 'package:clout/screens/register_or_modify/advertiser/widgets/advertiser_join_or_modify_1.dart';
import 'package:clout/screens/register_or_modify/advertiser/widgets/advertiser_join_or_modify_2.dart';
import 'package:clout/screens/register_or_modify/widgets/join_input.dart';
import 'package:clout/type.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// widgets
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/header/header.dart';

class AdvertiserModify extends StatefulWidget {
  AdvertiserModify({super.key});

  @override
  State<AdvertiserModify> createState() => _AdvertiserModifyState();
}

class _AdvertiserModifyState extends State<AdvertiserModify> {
  final advertiserController = Get.put(AdvertiserController());
  final controller = Get.put(
    AdvertiserInfoController(),
    tag: 'advertiserModify',
  );
  AuthorizedApi authorizedApi = AuthorizedApi();

  @override
  void initState() {
    advertiserController.setControllerTag('advertiserModify');
    controller.runOtherControllers();
    loadAdvertiserInfo();
    super.initState();
  }

  loadAdvertiserInfo() async {
    var response = await authorizedApi.getRequest(
        '/member-service/v1/advertisers/', userController.memberId);
    // response = {'statusCode' : 값, 'body' : 값}
    print(response['statusCode']);
    print(response['body']);
    var advertiserData = response['body'];
    var data = Advertiser.fromJson(jsonDecode(advertiserData));

    controller.loadBeforeModify(data);
  }

  showPasswordCheck() {
    Get.defaultDialog(
      title: '비밀번호 확인',
      titlePadding: EdgeInsets.only(top: 20),
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      content: GetBuilder<AdvertiserInfoController>(
        tag: advertiserController.controllerTag,
        builder: (controller) => SizedBox(
          height: 60,
          child: Stack(
            children: [
              JoinInput(
                keyboardType: TextInputType.text,
                maxLength: 20,
                title: '비밀번호 입력',
                label: '비밀번호',
                setState: controller.setPassword,
                obscured: controller.obscured,
                enabled: true,
              ),
              Positioned(
                top: 3,
                right: 5,
                child: IconButton(
                  onPressed: controller.setObscured,
                  icon: controller.obscured
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
        ),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: testLogin,
            style: ElevatedButton.styleFrom(
                backgroundColor: style.colors['main1']),
            child: Text("확인"),
          ),
        ),
      ],
    );
  }

  testLogin() async {
    LoginApi loginApi = LoginApi();
    var loginData = await loginApi.postRequest(
        '/member-service/v1/members/login',
        LoginInfo(controller.id, controller.password));
    if (loginData['login_success'] == true) {
      updateUserInfo();
    }
  }

  updateUserInfo() async {
    await controller.setAdvertiser();
    var response = await authorizedApi.putRequest(
      '/member-service/v1/advertisers/${userController.memberId}',
      controller.advertiser,
    );
    if (response['statusCode'] == 200) {
      Get.back();
      Get.back();
      Get.off(() => AdvertiserProfile());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvertiserInfoController>(
      tag: advertiserController.controllerTag,
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 4,
            headerTitle: '회원 정보 수정',
          ),
        ),
        body: Center(
          child: BouncingListview(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                children: [
                  AdvertiserJoinOrModify1(
                    modifying: true,
                    controllerTag: advertiserController.controllerTag,
                  ),
                  SizedBox(height: 20),
                  AdvertiserJoinOrModify2(
                    modifying: true,
                    controllerTag: advertiserController.controllerTag,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: BigButton(
                      title: '수정완료', // pageNum에 따라 버튼 텍스트 변경
                      function: showPasswordCheck,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
