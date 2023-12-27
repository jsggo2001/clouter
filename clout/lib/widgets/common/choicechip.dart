import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class ActionChoiceExample extends StatefulWidget {
  final List<String> labels;
  final int chipCount;
  final Function(String) onChipSelected;

  const ActionChoiceExample(
      {Key? key,
      required this.labels,
      required this.chipCount,
      required this.onChipSelected})
      : super(key: key);

  @override
  State<ActionChoiceExample> createState() => _ActionChoiceExampleState();
}

class _ActionChoiceExampleState extends State<ActionChoiceExample> {
  int? _value = 0; // 선택된 choicechip의 인덱스

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Wrap(
          spacing: 5,
          children: List<Widget>.generate(
            widget.chipCount,
            (int index) {
              return ChoiceChip(
                pressElevation: 0,
                showCheckmark: true,
                checkmarkColor: style.colors['main1'],
                surfaceTintColor: Colors.black,
                label: Text(widget.labels[index]),
                selected: _value == index,
                onSelected: (bool selected) {
                  setState(() {
                    _value = selected ? index : null;
                  });
                  if (selected) {
                    widget.onChipSelected(widget.labels[index]);
                  }
                },
                backgroundColor: _value == index
                    ? style.colors['main2']
                    : Colors.transparent,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: style.colors['category']!,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                selectedColor: style.colors['category'],
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
