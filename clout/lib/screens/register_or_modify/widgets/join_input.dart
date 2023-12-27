import 'dart:async';

import 'package:clout/providers/four_digits_input_controller.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

class JoinInput extends StatefulWidget {
  JoinInput(
      {super.key,
      required this.keyboardType,
      required this.maxLength,
      required this.title,
      required this.label,
      required this.setState,
      required this.enabled,
      this.index,
      this.obscured,
      this.initialValue,
      this.inputFormatters,
      this.textInputAction,
      this.controllerTag});
  final keyboardType;
  final maxLength;
  final title;
  final label;
  final setState;
  final index;
  final obscured;
  final enabled;
  final initialValue;
  var inputFormatters;
  var textInputAction;
  var controllerTag;

  @override
  State<JoinInput> createState() => _JoinInputState();
}

class _JoinInputState extends State<JoinInput> {
  final TextEditingController textEditingController = TextEditingController();

  late final focusNode = FocusNode();

  Timer _timer = Timer(Duration(milliseconds: 2000), () {});

  @override
  Widget build(BuildContext context) {
    if (widget.initialValue != null) {
      setState(() {
        textEditingController.text = widget.initialValue;
      });
    }
    return TextField(
      controller: textEditingController,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,
      // onChanged: widget.index == null
      //     ? (value) {
      //         if (_timer.isActive) _timer.cancel();
      //         _timer = Timer(
      //           const Duration(milliseconds: 1000),
      //           () {
      //             widget.setState(value);
      //           },
      //         );
      //         if (widget.controllerTag != null) {
      //           final pinController = Get.find<FourDigitsInputController>(
      //               tag: widget.controllerTag);
      //           pinController.setPhoneVerified(false);
      //         }
      //       }
      //     : (value) {
      //         if (_timer.isActive) _timer.cancel();
      //         _timer = Timer(
      //           const Duration(milliseconds: 1000),
      //           () {
      //             widget.setState(widget.index, value);
      //           },
      //         );
      //       },
      onTapOutside: widget.index == null
          ? (event) {
              widget.setState(textEditingController.text);
              // _timer.cancel();
            }
          : (event) {
              widget.setState(widget.index, textEditingController.text);
              // _timer.cancel();
            },
      obscureText: widget.obscured ?? false,
      decoration: InputDecoration(
        counterText: '',
        contentPadding: EdgeInsets.only(top: 30, left: 15, right: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        hintText: widget.title,
        labelText: widget.label,
        floatingLabelStyle: TextStyle(color: style.colors['main1']),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            width: 2,
            color: style.colors['main1']!,
          ),
        ),
      ),
    );
  }
}
