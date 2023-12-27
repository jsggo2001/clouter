import 'package:clout/widgets/platform_toggle_input/platform_toggle_input.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:clout/widgets/sns/platform_toggle.dart';

class ClouterJoinOrModify3 extends StatelessWidget {
  const ClouterJoinOrModify3(
      {super.key, required this.modifying, required this.controllerTag});
  final modifying;
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: [
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '3. SNS 정보',
                  style: style.textTheme.headlineMedium,
                ),
              ),
              SizedBox(height: 10),
              PlatformToggle(
                multiAllowed: false,
                controllerTag: controllerTag,
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        PlatformToggleInput(
          controllerTag: controllerTag,
        ),
      ],
    );
  }
}
