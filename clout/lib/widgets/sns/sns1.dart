import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

// widgets
import 'package:clout/widgets/sns/widgets/sns_item_box.dart';

class Sns1 extends StatelessWidget {
  const Sns1(
      {super.key,
      required this.snsType,
      required this.channelName,
      required this.followers,
      required this.link});

  final String snsType;
  final String channelName;
  final int followers;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // SnsItemBox(
        //   username: 'MochaMilk',
        //   followers: '165만',
        //   imageName: 'assets/images/YouTube.png',
        //   snsUrl: 'https://www.youtube.com/c/mochamilk',
        // ),
        // SizedBox(width: 5),
        // SnsItemBox(
        //   username: 'milk_the_samoyed',
        //   followers: '13만 4천',
        //   imageName: 'assets/images/INSTAGRAM.png',
        //   snsUrl: 'https://www.instagram.com/milk_the_samoyed/',
        // ),
        // SizedBox(width: 5),
        // SnsItemBox(
        //   username: 'mochamilk',
        //   followers: '15만',
        //   imageName: 'assets/images/TikTok.png',
        //   snsUrl: 'https://www.instagram.com/milk_the_samoyed/',
        // ),
      ],
    ));
  }
}
