// Global
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class DataTitleThin extends StatelessWidget {
  const DataTitleThin({super.key, required this.text, this.pdtop});
  final String text;
  final double? pdtop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: 5, top: pdtop ?? 0.0), // pdtop 값이 0일 경우 기본값 0.0 사용
      child: Text(text, style: TextStyle(fontSize: 18)),
    );
  }
}
