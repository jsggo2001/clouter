import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class ContractToggle extends StatefulWidget {
  const ContractToggle({Key? key}) : super(key: key);

  @override
  _ContractToggleState createState() => _ContractToggleState();
}

class _ContractToggleState extends State<ContractToggle> {
  List<bool> _selections1 = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          _selections1[index] = !_selections1[index];
        });
      },
      isSelected: _selections1,
      selectedBorderColor: Color(0x00ff0000), // 선택되었을 때의 테두리 색상
      borderColor: Color(0x00ff0000), // 선택되지 않았을 때의 테두리 색상
      fillColor: Color(0x00ff0000),
      children: <Widget>[
        Container(
          width: 80,
          height: 24,
          decoration: BoxDecoration(
            color: _selections1[0] ? style.colors['category'] : Color(0xFFE8ECF4),
            borderRadius: BorderRadius.all(Radius.circular(10))),
           child: Align(
            alignment: Alignment.center,
            child: Text('전체 내역'),
          ),
        ),
        Container(
          width: 80,
          height: 24,
          decoration: BoxDecoration(
            color: _selections1[1] ? style.colors['category'] : Color(0xFFE8ECF4), 
            borderRadius: BorderRadius.all(Radius.circular(10))),
      
           child: Align(
            alignment: Alignment.center,
            child: Text('완료'),
          ),
        ),
        Container(
          width: 80,
          height: 24,
          decoration: BoxDecoration(
            color: _selections1[2] ? style.colors['category'] : Color(0xFFE8ECF4), 
            borderRadius: BorderRadius.all(Radius.circular(10))),
           child: Align(
            alignment: Alignment.center,
            child: Text('진행 중'),
          ),
        ),
        Container(
          width: 80,
          height: 24,
          decoration: BoxDecoration(
            color: _selections1[3] ? style.colors['category'] : Color(0xFFE8ECF4), 
            borderRadius: BorderRadius.all(Radius.circular(10))),
            
           child: Align(
            alignment: Alignment.center,
            child: Text('예정'),
          ),
        ),
      ],
    );
  }
}
