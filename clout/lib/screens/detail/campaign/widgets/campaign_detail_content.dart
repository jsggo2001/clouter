import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class CampaignDetailContent extends StatelessWidget {
  final title;
  final Widget content;
  CampaignDetailContent(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 10),
      Text(title,
          style: style.textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w700)),
      SizedBox(height: 5),
      Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: content),
      SizedBox(height: 10)
    ]);
  }
}
