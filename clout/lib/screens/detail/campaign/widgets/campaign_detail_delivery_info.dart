import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class CampaignDetailDeliveryInfo extends StatelessWidget {
  CampaignDetailDeliveryInfo({super.key});

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
            Icons.local_shipping_outlined,
            size: 35,
            color: style.colors['main1'],
          ),
          SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '협찬 신청 후 제공 여부가',
                style: TextStyle(fontSize: 17, height: 1.3),
              ),
              Text('결정되면 즉시 배송됩니다.',
                  style: TextStyle(fontSize: 17, height: 1.3))
            ],
          )
        ],
      ),
    );
  }
}
