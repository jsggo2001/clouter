import 'package:clout/hooks/apis/register_api.dart';
import 'package:clout/providers/user_controllers/clouter_info_controller.dart';
import 'package:clout/screens/register_or_modify/widgets/join_input.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/buttons/small_button.dart';
import 'package:clout/widgets/image_pickder/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ClouterJoinOrModify2 extends StatelessWidget {
  ClouterJoinOrModify2(
      {super.key, required this.modifying, required this.controllerTag});
  final modifying;
  final controllerTag;

  //중복 체크 함수
  checkDuplicted() async {
    final clouterRegisterController =
        Get.find<ClouterInfoController>(tag: controllerTag);

    if (clouterRegisterController.id == null ||
        clouterRegisterController.id.length == 0) {
      Fluttertoast.showToast(msg: '아이디를 입력해주세요');
    } else {
      final RegisterApi registerApi = RegisterApi();

      var responseBody = await registerApi.getRequest(
        '/member-service/v1/members/duplicate',
        '?userId=${clouterRegisterController.id}',
      );
      print(responseBody);
      if (responseBody[0] == 200) {
        // 사용 가능한 아이디
        clouterRegisterController.setDoubleId(1);
      } else if (responseBody[0] == 409) {
        // 중복된 아이디
        clouterRegisterController.setDoubleId(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClouterInfoController>(
      tag: controllerTag,
      builder: (controller) => FractionallySizedBox(
        widthFactor: 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '2. 계정 설정',
                  style: style.textTheme.headlineMedium,
                  textAlign: TextAlign.left,
                ),
                modifying?
                SizedBox(
                  height: 25,
                  child: BigButton(
                    function: () {},
                    title: '비밀번호 변경',
                    textStyle: style.textTheme.bodySmall,
                    fontWeight: FontWeight.normal,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  ),
                ) : Container(),
              ],
            ),
            SizedBox(height: 20),
            JoinInput(
              keyboardType: TextInputType.text,
              maxLength: 20,
              title: '닉네임 입력',
              label: '닉네임',
              setState: controller.setNickName,
              initialValue: controller.nickName,
              enabled: true,
            ),
            SizedBox(height: 10),
            Stack(
              children: [
                JoinInput(
                  keyboardType: TextInputType.text,
                  maxLength: 15,
                  title: '아이디 입력',
                  label: '아이디',
                  setState: controller.setId,
                  initialValue: controller.id,
                  enabled: !modifying,
                ),
                controllerTag != 'clouterModify'
                    ? Positioned(
                        right: 10,
                        top: 2,
                        child: ElevatedButton(
                          onPressed: checkDuplicted,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: style.colors['main1'],
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text('중복 확인'),
                        ),
                      )
                    : Container(),
              ],
            ),
            controllerTag != 'clouterModify'
                ? Align(
                    alignment: Alignment.centerRight,
                    child: controller.doubleId == 0
                        ? Text(
                            '아이디 중복 확인이 필요해요',
                            style: style.textTheme.bodySmall?.copyWith(
                              color: style.colors['gray'],
                              height: 1.5,
                            ),
                          )
                        : controller.doubleId == 1
                            ? Text(
                                '사용 가능한 아이디입니다',
                                style: style.textTheme.bodySmall?.copyWith(
                                  color: style.colors['main1'],
                                  height: 1.5,
                                ),
                              )
                            : Text(
                                '이미 사용 중인 아이디입니다',
                                style: style.textTheme.bodySmall?.copyWith(
                                  color: Colors.red[300],
                                  height: 1.5,
                                ),
                              ),
                  )
                : SizedBox(height: 5),
            SizedBox(height: 5),
            modifying != true
                ? Column(
                    children: [
                      Stack(
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
                      SizedBox(height: 10),
                      Stack(
                        children: [
                          JoinInput(
                            keyboardType: TextInputType.text,
                            maxLength: 20,
                            title: '비밀번호 확인',
                            label: '비밀번호 확인',
                            setState: controller.setCheckPassword,
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
                    ],
                  )
                : Container(),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10),
                Text(
                  '활동 대표 사진',
                  style: style.textTheme.headlineSmall,
                ),
                SizedBox(height: 10),
                ImageWidget(controllerTag: controllerTag),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
