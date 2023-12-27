import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:clout/style.dart' as style;

class DropdownInputUnder extends StatelessWidget {
  const DropdownInputUnder(
      {super.key,
      this.placeholder,
      this.data,
      this.setData,
      this.value,
      this.offset});

  final placeholder;
  final data;
  final setData;
  final value;
  final offset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 55,
        child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Colors.black38,
              )),
            ),
            child: DropdownButton2(
              underline: SizedBox.shrink(),
              alignment: Alignment.centerLeft,
              hint: Text(placeholder),
              isExpanded: true,
              value: value,
              dropdownStyleData: DropdownStyleData(
                offset: offset ?? Offset(0, 0),
                maxHeight: 300,
                scrollPadding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: style.colors['main1']!)),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: MaterialStateProperty.all(6),
                  thumbVisibility: MaterialStateProperty.all(true),
                ),
              ),
              items: data.map<DropdownMenuItem<String>>((e) {
                return DropdownMenuItem<String>(
                  value: e,
                  child: Container(width: 100, child: Text(e)),
                );
              }).toList(),
              onChanged: (selected) => setData(selected),
            )));
  }
}
