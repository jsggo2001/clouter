import 'dart:convert';

import 'package:clout/hooks/phone_number_formatter.dart';
import 'package:clout/hooks/apis/register_api.dart';
import 'package:clout/providers/four_digits_input_controller.dart';
import 'package:clout/providers/user_controllers/advertiser_info_controller.dart';
import 'package:clout/screens/register_or_modify/widgets/number_verify.dart';
import 'package:clout/screens/register_or_modify/widgets/join_input.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

class AdvertiserJoinOrModify2 extends StatelessWidget {
  AdvertiserJoinOrModify2(
      {super.key, required this.modifying, required this.controllerTag});
  final modifying;
  final controllerTag;

  final RegisterApi registerApi = RegisterApi();

  checkDuplicted() async {
    final advertiserInfoController =
        Get.find<AdvertiserInfoController>(tag: controllerTag);
    var responseBody = await registerApi.getRequest(
      '/member-service/v1/members/duplicate',
      '?userId=${advertiserInfoController.id}',
    );
    print('중복확인');
    print(responseBody);
    if (responseBody[0] == 200) {
      advertiserInfoController.setDoubleId(1);
    } else {
      advertiserInfoController.setDoubleId(2);
    }
  }

  verify() async {
    final advertiserInfoController =
        Get.find<AdvertiserInfoController>(tag: controllerTag);
    // var responseBody = await registerApi.getRequest('/member-service/v1/members/sendsms',
    var responseBody = await registerApi.getRequest(
        '/member-service/v1/members/sendsms',
        '?phoneNumber=${advertiserInfoController.phoneNumber}');
    print('인증키 sms 발송');
    final pinController =
        Get.find<FourDigitsInputController>(tag: controllerTag);
    pinController.setCorrectPin(responseBody[1]);
    print(pinController.correctPin);
    Get.to(() => NumberVerify(
        phoneNumber: advertiserInfoController.phoneNumber,
        controllerTag: 'advertiserRegister'));
  }

  @override
  Widget build(BuildContext context) {
    final pinController =
        Get.find<FourDigitsInputController>(tag: controllerTag);
    return GetBuilder<AdvertiserInfoController>(
      tag: controllerTag,
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Text(
            '2. 담당자 정보 및 계정 설정',
            style: style.textTheme.headlineMedium,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20),
          Text(
            '담당자 정보',
            style: style.textTheme.headlineMedium,
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          JoinInput(
            keyboardType: TextInputType.text,
            maxLength: 20,
            title: '담당자 이름 입력',
            label: '담당자 이름',
            setState: controller.setName,
            initialValue: controller.name,
            enabled: true,
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              JoinInput(
                keyboardType: TextInputType.phone,
                maxLength: 13,
                title: '담당자 휴대전화 번호 입력',
                label: '담당자 휴대전화 번호',
                setState: controller.setPhoneNumber,
                initialValue: controller.phoneNumber,
                enabled: true,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  PhoneNumberFormatter(),
                ],
                controllerTag: controllerTag,
              ),
              Positioned(
                  right: 10,
                  top: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!pinController.phoneVerified) {
                        if (controller.phoneNumber != null &&
                            controller.phoneNumber.length != 0) {
                          verify();
                        } else {
                          Fluttertoast.showToast(msg: '휴대전화 번호를 입력해주세요');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: pinController.phoneVerified
                          ? style.colors['main1-3']
                          : style.colors['main1'],
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: pinController.phoneVerified
                        ? Icon(Icons.check_circle_outline)
                        : Text('인증'),
                  ),
                ),
            ],
          ),
          SizedBox(height: 20),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '계정 설정',
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
              controllerTag != 'advertiserModify'
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
          controllerTag != 'advertiserModify'
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
                                color: style.colors['Darkgray'],
                                height: 1.5,
                              ),
                            ),
                )
              : SizedBox(height: 10),
          !modifying
              ? Column(
                  children: [
                    Stack(
                      children: [
                        JoinInput(
                          keyboardType: TextInputType.text,
                          maxLength: 30,
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
                                    Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
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
                          maxLength: 30,
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
                                    Icons.visibility_off_outlined,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.grey,
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
