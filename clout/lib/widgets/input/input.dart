import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

class Input extends StatelessWidget {
  Input(
      {super.key,
      this.placeholder,
      this.setText,
      this.suffixIcon,
      this.obscure,
      this.setObscured,
      this.enabled,});

  final placeholder;
  final setText;
  final suffixIcon;
  final obscure;
  final setObscured;
  final enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (enabled != false) {
          setText(value);
        }
      },
      obscureText: obscure != null ? obscure : false,
      enabled: enabled != false, 
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: placeholder,
          suffixIcon: suffixIcon != null && setObscured != null
              ? IconButton(
                  onPressed: () {
                    setObscured();
                  },
                  icon: suffixIcon)
              : null),
    );
  }
}
