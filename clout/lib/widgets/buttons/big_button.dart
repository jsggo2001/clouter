import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

class BigButton extends StatelessWidget {
  BigButton({
    super.key,
    required this.title,
    required this.function,
    this.textColor,
    this.buttonColor,
    this.icon,
    this.padding,
    this.fontWeight,
    this.fontHeight,
    this.textStyle,
  }) {
    textColor ??= style.colors['white'];
    buttonColor ??= style.colors['main1'];
    padding ??= EdgeInsets.symmetric(vertical: 12);
    fontWeight ??= FontWeight.w600;
    fontHeight ??= 1.2;
    textStyle ??= style.textTheme.headlineLarge;
  }

  final title;
  final function;
  Color? textColor;
  Color? buttonColor;
  final icon;
  EdgeInsetsGeometry? padding;
  FontWeight? fontWeight;
  double? fontHeight;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: icon != null
          ? Row(
              children: [
                SizedBox(width: 20),
                icon,
                SizedBox(width: 20),
                Text(
                  title,
                  style: textStyle?.copyWith(
                    color: textColor,
                    fontWeight: fontWeight,
                    height: fontHeight,
                  ),
                ),
              ],
            )
          : Text(
              title,
              style: textStyle?.copyWith(
                color: textColor,
                fontWeight: fontWeight,
                height: fontHeight,
              ),
            ),
    );
  }
}
