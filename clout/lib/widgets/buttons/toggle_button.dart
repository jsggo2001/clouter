import 'dart:math';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton(
      {super.key,
      this.parentPositive,
      this.setPositive,
      this.leftIcon,
      this.rightIcon});
  final parentPositive; // on off 속성
  final setPositive; // 상위 위젯에서 on off state 설정해주는 함수
  final leftIcon; // 왼쪽 아이콘
  final rightIcon; // 오른쪽 아이콘

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool positive = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 45,
      child: DefaultTextStyle.merge(
        style: const TextStyle(
            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        child: IconTheme.merge(
          data: IconThemeData(color: Colors.white),
          child: AnimatedToggleSwitch<bool>.dual(
            current: positive,
            first: false,
            second: true,
            spacing: 0.0,
            animationDuration: const Duration(milliseconds: 200),
            style: ToggleStyle(
              borderColor: Colors.transparent,
              indicatorColor: Colors.white,
              backgroundColor: style.colors['category'],
            ),
            customStyleBuilder: (context, local, global) {
              if (global.position <= 0.0) {
                return ToggleStyle();
              }
              return ToggleStyle(
                  backgroundGradient: LinearGradient(
                colors: [style.colors['main1']!, style.colors['category']!],
                stops: [
                  global.position -
                      (1 - 2 * max(0, global.position - 0.5)) * 0.7,
                  global.position + max(0, 2 * (global.position - 0.5)) * 0.7,
                ],
              ));
            },
            height: 25.0,
            onChanged: (b) => setState(() {
              positive = b;
              widget.setPositive(b);
            }),
            iconBuilder: (value) => value
                ? Icon(widget.rightIcon,
                    color: style.colors['main1'], size: 18.0)
                : Icon(widget.leftIcon,
                    color: style.colors['main1'], size: 18.0),
            textBuilder: (value) =>
                value ? Center(child: Text('')) : Center(child: Text('')),
          ),
        ),
      ),
    );
  }
}
