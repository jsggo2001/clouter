import 'package:clout/providers/four_digits_input_controller.dart';
import 'package:clout/providers/user_controllers/clouter_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:clout/style.dart' as style;
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';

class FourDigitsInput extends StatefulWidget {
  FourDigitsInput({super.key, required this.controllerTag});
  final controllerTag;

  @override
  State<FourDigitsInput> createState() => _FourDigitsInputState();
}

class _FourDigitsInputState extends State<FourDigitsInput>
    with TickerProviderStateMixin {
  late AnimationController checkController;

  @override
  void initState() {
    super.initState();
    checkController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    checkController.dispose();
    super.dispose();
  }

  // final focusNode = FocusNode();

  // final formKey = GlobalKey<FormState>();

  // @override
  @override
  Widget build(BuildContext context) {
    checkController.reset();
    checkController.forward();
    var focusedBorderColor = style.colors['main1']!;
    var fillColor = Color.fromRGBO(243, 246, 249, 0);
    var borderColor = style.colors['main1-4']!;

    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: borderColor,
        ),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return GetBuilder<FourDigitsInputController>(
      tag: widget.controllerTag,
      builder: (controller) => Form(
        // key: formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              // controller: controller,
              // focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) async {
                controller.setInputPin(pin);
                checkController.reset();
                checkController.forward();
                if (controller.inputPin == controller.correctPin) {
                  await controller.setPhoneVerified(true);
                  await Future.delayed(Duration(seconds: 2), () => Get.back());
                }
              },
              onChanged: (value) => controller.setInputPin(value),
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: focusedBorderColor, width: 2),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     // focusNode.unfocus();
          //     // formKey.currentState!.validate();
          //   },
          //   child: const Text('Validate'),
          // ),
          SizedBox(height: 30),
          // BigButton(
          //   function: () {},
          //   title: '인증하기',
          // )
          controller.inputPin != null &&
                  controller.correctPin != null &&
                  controller.inputPin.length == 4 &&
                  controller.inputPin == controller.correctPin
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Lottie.asset(
                        Icons8.check_circle_color,
                        controller: checkController,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '인증되었습니다.',
                      style:
                          style.textTheme.headlineLarge?.copyWith(height: 1.2),
                    ),
                  ],
                )
              : controller.inputPin != null &&
                      controller.correctPin != null &&
                      controller.inputPin.length == 4 &&
                      controller.inputPin != controller.correctPin
                  ? Wrap(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          child: Lottie.asset(
                            Icons8.icons8_close_4_,
                            controller: checkController,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '인증번호를 다시 확인해주세요.',
                          style: style.textTheme.headlineLarge
                              ?.copyWith(height: 1.2),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )
                  : Container(),
        ]),
      ),
    );
  }
}
