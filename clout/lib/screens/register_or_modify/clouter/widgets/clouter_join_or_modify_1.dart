import 'package:clout/hooks/phone_number_formatter.dart';
import 'package:clout/hooks/apis/register_api.dart';
import 'package:clout/providers/four_digits_input_controller.dart';
import 'package:clout/providers/user_controllers/clouter_info_controller.dart';
import 'package:clout/screens/register_or_modify/widgets/join_input.dart';
import 'package:clout/widgets/input/address_input.dart';
import 'package:clout/widgets/input/input_elements/widgets/date_input.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:clout/screens/register_or_modify/widgets/number_verify.dart';

class ClouterJoinOrModify1 extends StatefulWidget {
  ClouterJoinOrModify1({
    super.key,
    required this.modifying,
    required this.controllerTag,
  });

  final controllerTag;
  final modifying;
  static final formkey = GlobalKey();

  @override
  State<ClouterJoinOrModify1> createState() => _ClouterJoinOrModify1State();
}

class _ClouterJoinOrModify1State extends State<ClouterJoinOrModify1> {
  final RegisterApi registerApi = RegisterApi();

  @override
  void initState() {
    super.initState();
  }

  verify() async {
    final clouterRegisterController =
        Get.find<ClouterInfoController>(tag: widget.controllerTag);
    var responseBody = await registerApi.getRequest(
        '/member-service/v1/members/sendsms',
        '?phoneNumber=${clouterRegisterController.phoneNumber}');
    print('인증키 sms 발송');
    final pinController =
        Get.find<FourDigitsInputController>(tag: widget.controllerTag);
    pinController.setCorrectPin(responseBody[1]);
    print(pinController.correctPin);
    Get.to(() => NumberVerify(
        phoneNumber: clouterRegisterController.phoneNumber,
        controllerTag: widget.controllerTag));
  }

  @override
  Widget build(BuildContext context) {
    final pinController =
        Get.find<FourDigitsInputController>(tag: widget.controllerTag);
    return GetBuilder<ClouterInfoController>(
      tag: widget.controllerTag,
      builder: (controller) => FractionallySizedBox(
        widthFactor: 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. 기본 정보',
              style: style.textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            JoinInput(
              keyboardType: TextInputType.text,
              maxLength: 20,
              title: '이름 입력',
              label: '이름',
              setState: controller.setName,
              initialValue: controller.name,
              enabled: !widget.modifying,
            ),
            SizedBox(height: 10),
            DateInput(controllerTag: widget.controllerTag),
            SizedBox(height: 10),
            Stack(
              children: [
                JoinInput(
                  keyboardType: TextInputType.phone,
                  maxLength: 13,
                  title: '휴대전화 번호 입력',
                  label: '휴대전화 번호',
                  setState: controller.setPhoneNumber,
                  initialValue: controller.phoneNumber,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    PhoneNumberFormatter(),
                  ],
                  enabled: true,
                  controllerTag: widget.controllerTag,
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
            SizedBox(height: 10),
            AddressInput(controllerTag: widget.controllerTag),
          ],
        ),
      ),
    );
  }
}
