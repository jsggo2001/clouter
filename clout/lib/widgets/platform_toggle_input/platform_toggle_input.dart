import 'package:clout/widgets/platform_toggle_input/input_customdrop.dart';
import 'package:flutter/material.dart'
    hide BoxDecoration, BoxShadow; //  기존 BoxShadow 속성을 가려줘야 함

class PlatformToggleInput extends StatelessWidget {
  PlatformToggleInput({super.key, required this.controllerTag});
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 인스타그램 입력 창
        InputCustomdrop(
          index: 0,
          controllerTag: controllerTag,
        ),
        // 틱톡 입력 창
        InputCustomdrop(
          index: 1,
          controllerTag: controllerTag,
        ),
        // 유튜브 입력 창
        InputCustomdrop(
          index: 2,
          controllerTag: controllerTag,
        ),
      ],
    );
  }
}
