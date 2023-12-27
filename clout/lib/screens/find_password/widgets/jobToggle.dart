import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class JobToggle extends StatefulWidget {
  const JobToggle({Key? key}) : super(key: key);

  @override
  _JobToggleState createState() => _JobToggleState();
}

class _JobToggleState extends State<JobToggle> {
  List<bool> _selections1 = [false, false];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      onPressed: (int index) {
        setState(() {
          _selections1[index] = !_selections1[index];
        });
      },
      isSelected: _selections1,
      // selectedBorderColor: style.colors['category'], // 선택되었을 때의 테두리 색상
      borderColor: Color(0xFFF7F8F9), // 선택되지 않았을 때의 테두리 색상
      children: <Widget>[
        Container(
          width: 168,
          height: 60,
          decoration: BoxDecoration(
            color: _selections1[0] ? style.colors['category'] : Color(0xFFE8ECF4),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),  
              bottomLeft: Radius.circular(8),
                  ),),
           child: Align(
            alignment: Alignment.center,
            child: Text('광고주',style: style.textTheme.headlineSmall,),
          ),
        ),
        Container(
          width: 168,
          height: 60,
          decoration: BoxDecoration(
            color: _selections1[1] ? style.colors['category'] : Color(0xFFE8ECF4),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),   
              bottomRight: Radius.circular(8), 
            ),),
           child: Align(
            alignment: Alignment.center,
            child: Text('클라우터', style: style.textTheme.headlineSmall,),
          ),
        ),
      ],
    );
  }
}
