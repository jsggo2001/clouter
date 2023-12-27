import 'package:clout/screens/register_or_modify/widgets/four_digits_input.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class NumberVerify extends StatelessWidget {
  const NumberVerify(
      {super.key, required this.phoneNumber, required this.controllerTag});
  final phoneNumber;
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 1,
          child: BouncingListview(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 150),
                    Text('문자로 발송된', style: style.textTheme.titleMedium),
                    Row(
                      children: [
                        Text('인증번호',
                            style: style.textTheme.titleMedium
                                ?.copyWith(color: style.colors['main1'])),
                        Text('를', style: style.textTheme.titleMedium),
                      ],
                    ),
                    Text('입력해 주세요', style: style.textTheme.titleMedium),
                    SizedBox(height: 10),
                    Text(
                      phoneNumber,
                      style: style.textTheme.headlineLarge,
                    ),
                  ],
                ),
                SizedBox(height: 30),
                FourDigitsInput(controllerTag: controllerTag),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
