import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:url_launcher/url_launcher.dart';

class SnsItemBox extends StatelessWidget {
  final String username;
  final int followers;
  final String snsType;
  final String snsUrl;

  SnsItemBox({
    super.key,
    required this.username, // 채널명 · 계정명
    required this.followers, // 구독자수 · 팔로워수
    required this.snsType, // Youtube · Instagram · TikTok
    required this.snsUrl, // sns 링크
  });

  @override
  Widget build(BuildContext context) {
    String formattedNum = '';

    if (followers >= 10000) {
      if (followers % 10000 == 0) {
        if (followers % 100000000 == 0) {
          formattedNum = '${(followers ~/ 100000000)}억';
        } else {
          formattedNum = '${(followers ~/ 10000)} 만';
        }
      } else {
        if (followers % 100000000 == 0) {
          formattedNum = (followers / 100000000).toStringAsFixed(1) + '억';
        } else {
          formattedNum = (followers / 10000).toStringAsFixed(2) + '만';
        }
      }
    }

    return GestureDetector(
        onTap: () {
          launchUrl(Uri.parse('https://$snsUrl'));
          print('연결된 링크로 이동~👻');
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: style.colors['main3'],
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 1,
                child: Image.asset('assets/images/${snsType}.png',
                    width: 40, height: 40),
              ),
              Flexible(
                flex: 3,
                child: Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  formattedNum,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Flexible(
                flex: 1,
                child: Icon(Icons.ads_click, color: style.colors['main1']),
              ),
            ],
            // )
            // ],
          ),
        )
        // Container(
        //   width: 110,
        //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        //   margin: EdgeInsets.only(right: 10),
        //   decoration: BoxDecoration(
        //     color: style.colors['main3'],
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Image.asset('assets/images/${snsType}.png', width: 40, height: 40),
        //       SizedBox(height: 7),
        //       Text(
        //         username,
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 13,
        //         ),
        //         maxLines: 1,
        //         overflow: TextOverflow.ellipsis,
        //       ),
        //       Text(
        //         formattedNum,
        //         maxLines: 1,
        //         overflow: TextOverflow.ellipsis,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
