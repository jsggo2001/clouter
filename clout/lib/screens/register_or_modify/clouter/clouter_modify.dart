import 'dart:convert';

import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/hooks/apis/login_api.dart';
import 'package:clout/hooks/pictures/image_functions.dart';
import 'package:clout/providers/image_picker_controller.dart';
import 'package:clout/providers/user_controllers/clouter_controller.dart';
import 'package:clout/providers/user_controllers/clouter_info_controller.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:clout/screens/profile/clouter/clouter_profile.dart';
import 'package:clout/screens/register_or_modify/clouter/widgets/clouter_join_or_modify_1.dart';
import 'package:clout/screens/register_or_modify/clouter/widgets/clouter_join_or_modify_2.dart';
import 'package:clout/screens/register_or_modify/clouter/widgets/clouter_join_or_modify_3.dart';
import 'package:clout/screens/register_or_modify/clouter/widgets/clouter_join_or_modify_4.dart';
import 'package:clout/screens/register_or_modify/widgets/join_input.dart';
import 'package:clout/type.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// widgets
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/header/header.dart';

class ClouterModify extends StatefulWidget {
  ClouterModify({super.key});

  @override
  State<ClouterModify> createState() => _ClouterModifyState();
}

class _ClouterModifyState extends State<ClouterModify> {
  final clouterController = Get.put(ClouterController());

  final controller = Get.put(ClouterInfoController(), tag: 'clouterModify');

  bool _isLoading = true;

  AuthorizedApi authorizedApi = AuthorizedApi();

  loadClouterInfo() async {
    var response = await authorizedApi.getRequest(
        '/member-service/v1/clouters/', userController.memberId);
    // response = {'statusCode' : 값, 'body' : 값}
    print(response['statusCode']);
    print(response['body']);
    var clouterData = response['body'];
    var data = Clouter.fromJson(jsonDecode(clouterData));

    await controller.loadBeforeModify(data);
    _isLoading = false;
  }

  @override
  void initState() {
    clouterController.setControllerTag('clouterModify');
    controller.runOtherControllers();
    loadClouterInfo();
    super.initState();
  }

  updateUserInfo() async {
    await controller.setClouter();

    final imageController =
        Get.find<ImagePickerController>(tag: clouterController.controllerTag);

    ImageFunctions imageFunctions = ImageFunctions();

    var imageFiles = await imageFunctions
        .pickedImagesToMultiPartFiles(imageController.images);

    var response = await authorizedApi.dioPutRequest(
      '/member-service/v1/clouters/${userController.memberId}',
      controller.clouter,
      imageFiles,
    );
    if (response.statusCode == 200) {
      Get.back();
      Get.back();
      Get.off(() => ClouterProfile());
    }
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

  showPasswordCheck() {
    Get.defaultDialog(
      title: '비밀번호 확인',
      titlePadding: EdgeInsets.only(top: 20),
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      content: GetBuilder<ClouterInfoController>(
        tag: clouterController.controllerTag,
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClouterInfoController>(
      tag: clouterController.controllerTag,
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 4,
            headerTitle: '회원 정보 수정',
          ),
        ),
        body: _isLoading
            ? SizedBox(
                height: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      left: 160,
                      right: 160,
                      top: 0,
                      bottom: 280,
                      child: SizedBox(
                        height: 100,
                        child: LoadingWidget(),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 100,
                      child: Align(
                        child: Text(
                          '사용자 정보를 불러오는 중입니다.\n잠시만 기다려 주세요',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : BouncingListview(
                child: Column(
                  children: [
                    ClouterJoinOrModify1(
                      modifying: true,
                      controllerTag: 'clouterModify',
                    ),
                    ClouterJoinOrModify2(
                      modifying: true,
                      controllerTag: 'clouterModify',
                    ),
                    ClouterJoinOrModify3(
                      modifying: true,
                      controllerTag: 'clouterModify',
                    ),
                    ClouterJoinOrModify4(
                      modifying: true,
                      controllerTag: 'clouterModify',
                    ),
                    SizedBox(height: 20),
                    FractionallySizedBox(
                      widthFactor: 1,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: BigButton(
                          title: '완료', // pageNum에 따라 버튼 텍스트 변경
                          function: showPasswordCheck,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }
}
