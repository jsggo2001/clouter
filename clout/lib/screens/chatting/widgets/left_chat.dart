import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class LeftChat extends StatelessWidget {
  final String message;

  LeftChat(this.message);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 말풍선과 Text를 아래로 정렬
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start, // 말풍선을 왼쪽으로 이동
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 18),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/clouterImage.jpg',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Text를 왼쪽 정렬
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                  margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  constraints: BoxConstraints(maxWidth: 250), // 최대 width 설정
                  decoration: BoxDecoration(
                    color: Color(0xFFE8ECF4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    softWrap: true, // 줄바꿈 활성화
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '11:17',
                    style: TextStyle(
                      fontSize: 11,
                      color: style.colors['gray'],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
