
// Global
import 'package:clout/utilities/my_scroll.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:clout/style.dart' as style;

class NumberPickerDialog extends StatelessWidget {
  NumberPickerDialog({
    super.key,
    this.value,
    this.minValue,
    this.maxValue,
    this.setData,
  });

  var value;
  final minValue;
  final maxValue;
  final setData;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("모집인원"),
      content: StatefulBuilder(builder: (context, setState) {
        return ScrollConfiguration(
            behavior: MyScroll(),
            child: NumberPicker(
              value: value,
              minValue: minValue,
              maxValue: maxValue,
              onChanged: (newVal) {
                setState(() => value = newVal);
              },
              selectedTextStyle: TextStyle(
                  color: style.colors['main1'],
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26),
              ),
            ));
      }),
      actions: <Widget>[
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              setData(value);
              Navigator.of(context).pop(); //창 닫기
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: style.colors['main1']),
            child: Text("확인"),
          ),
        ),
      ],
    );
  }
}
