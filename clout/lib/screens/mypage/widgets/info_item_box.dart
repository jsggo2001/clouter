import 'package:flutter/material.dart';

// widgets
import 'package:clout/screens/mypage/widgets/content_text.dart';
import 'package:clout/screens/mypage/widgets/gray_title.dart';

class InfoItemBox extends StatelessWidget {
  const InfoItemBox(
      {super.key, required this.titleName, required this.contentInfo});

  final String titleName;
  final String contentInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: GrayTitle(title: titleName),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: ContentText(content: contentInfo),
            )
          ],
        ));
  }
}
