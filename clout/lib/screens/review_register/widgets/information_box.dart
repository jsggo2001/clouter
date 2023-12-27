import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class InformationBox extends StatelessWidget {
  const InformationBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.fromLTRB(20, 35, 20, 30),
        decoration: BoxDecoration(
          color: style.colors['white'],
          borderRadius: BorderRadius.circular(10),
          boxShadow: style.shadows['shadow'],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/clouterImage.jpg',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 20, // 이미지와 텍스트 사이의 간격 설정
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('모카우유',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    )),
                Text('2023.10.01 ~ 2023.10.25',
                    style: TextStyle(
                      fontSize: 15,
                    )),
                Text('80만 포인트',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: style.colors['main1'],
                    )),
              ],
            )
          ],
        ));
  }
}
