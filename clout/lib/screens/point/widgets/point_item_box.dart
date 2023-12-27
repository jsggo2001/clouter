import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PointItemBox extends StatefulWidget {
  const PointItemBox(
      {super.key,
      required this.type,
      required this.time,
      required this.title,
      required this.point});

  final String type;
  final String time;
  final String title;
  final int point; //string? int?

  @override
  State<PointItemBox> createState() => _PointItemBoxState();
}

class _PointItemBoxState extends State<PointItemBox> {
  var f = NumberFormat('###,###,###,###');

  Color getTextColor() {
    // ALL, DEAL, CHARGE, WITHDRAWAL
    switch (widget.type) {
      case '충전':
        return Colors.blue[700]!;
      case '출금':
        return Colors.red;
      case '사용':
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = getTextColor();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(255, 208, 208, 208),
          ),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.time),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(widget.type,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: textColor,
                    )),
                Text(f.format(widget.point),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: textColor,
                    ))
              ],
            )
          ],
        )
      ]),
    );
  }
}
