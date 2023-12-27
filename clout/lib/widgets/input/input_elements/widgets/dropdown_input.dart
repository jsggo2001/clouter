import 'package:clout/type.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:clout/style.dart' as style;

class DropdownInput extends StatelessWidget {
  DropdownInput(
      {super.key,
      this.placeholder,
      required this.data,
      this.setData,
      this.value,
      this.offset});

  final placeholder;
  List<Category> data;
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
            border: Border.all(
                color: Colors.black38, width: 1), //border of dropdown button
            borderRadius:
                BorderRadius.circular(5)), //border raiuds of dropdown button),
        child: DropdownButton2(
          buttonStyleData:
              ButtonStyleData(padding: EdgeInsets.only(right: 10, top: 3)),
          underline: SizedBox.shrink(),
          hint: Text(placeholder),
          iconStyleData: IconStyleData(
              icon: Icon(Icons.keyboard_arrow_down_rounded),
              openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded)),
          isExpanded: true,
          value: value,
          dropdownStyleData: DropdownStyleData(
            offset: offset ?? Offset(0, 0),
            maxHeight: 300,
            scrollPadding: EdgeInsets.only(top: 5, bottom: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border.all(color: style.colors['main1']!)),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          items: data.map<DropdownMenuItem<String>>((e) {
            return DropdownMenuItem<String>(
              value: e.english,
              child: SizedBox(width: 100, child: Text(e.korean)),
            );
          }).toList(),
          onChanged: (selected) {
            print(selected);
            setData(selected);
          },
        ),
      ),
    );
  }
}
