import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class CampaignDetailVisit extends StatelessWidget {
  CampaignDetailVisit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(5))),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.where_to_vote_outlined,
            color: style.colors['main1'],
            size: 35,
          ),
          SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '방문/체험형 캠페인이므로',
                style: TextStyle(fontSize: 17, height: 1.3),
              ),
              Text('채택 후 매장으로 방문 바랍니다.',
                  style: TextStyle(fontSize: 17, height: 1.3))
            ],
          )
        ],
      ),
    );
  }
}
