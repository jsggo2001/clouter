// global
import 'package:clout/screens/register_or_modify/advertiser/advertiser_join.dart';
import 'package:clout/screens/register_or_modify/clouter/clouter_join.dart';
import 'package:clout/widgets/buttons/gradient_button.dart';
import 'package:clout/widgets/image_carousel.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

final List<String> imgList = [
  'assets/images/join1.png',
  'assets/images/join2.png',
  'assets/images/join3.png',
  // 'assets/images/join4.png',
];

final List<Widget> imageSliders = imgList
    .map((item) => Padding(
          padding: const EdgeInsets.all(0),
          child: Image.asset(item, fit: BoxFit.cover),
        ))
    .toList();

class JoinPage extends StatelessWidget {
  const JoinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(height: 50),
                ImageCarousel(
                    imageSliders: imageSliders, aspectRatio: 1, enlarge: true),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GradientButton(
                    title: '광고주로 가입하기',
                    onPressed: () => Get.to(AdvertiserJoin()),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GradientButton(
                    title: '클라우터로 가입하기',
                    onPressed: () => Get.to(ClouterJoin()),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),

      /////////////////////////////////////////////////////////////

      // backgroundColor: Colors.white,
      // body: Stack(
      //   children: [
      //     Column(
      //       children: <Widget>[
      //         Expanded(
      //           flex: 4,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               ImageCarousel(
      //                   imageSliders: imageSliders,
      //                   aspectRatio: 1,
      //                   enlarge: true),
      //             ],
      //           ),
      //         ),
      //         Container(
      //           alignment: Alignment.bottomCenter,
      //           color: style.colors['white'],
      //           child: Container(
      //             decoration: BoxDecoration(
      //               color: style.colors['main3'],
      //               border: Border.symmetric(
      //                 horizontal: BorderSide(
      //                     width: 1, color: style.colors['category']!),
      //               ),
      //             ),
      //             height: 130,
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   flex: 1,
      //                   child: InkWell(
      //                     onTap: () => Get.to(AdvertiserJoin()),
      //                     child: Column(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         crossAxisAlignment: CrossAxisAlignment.center,
      //                         children: [
      //                           Text(
      //                             '광고주로',
      //                             style: TextStyle(
      //                               fontWeight: FontWeight.w500,
      //                               fontSize: 17,
      //                             ),
      //                           ),
      //                           Text(
      //                             '시작하기',
      //                             style: TextStyle(
      //                               fontWeight: FontWeight.w500,
      //                               fontSize: 17,
      //                             ),
      //                           ),
      //                         ]),
      //                   ),
      //                 ),
      //                 Container(
      //                     color: style.colors['main2'],
      //                     height: 100,
      //                     width: 0.3),
      //                 Expanded(
      //                   flex: 1,
      //                   child: InkWell(
      //                     onTap: () => Get.to(ClouterJoin()),
      //                     child: Column(
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       children: [
      //                         Text(
      //                           '클라우터로',
      //                           style: TextStyle(
      //                             fontWeight: FontWeight.w500,
      //                             fontSize: 17,
      //                           ),
      //                         ),
      //                         Text(
      //                           '시작하기',
      //                           style: TextStyle(
      //                             fontWeight: FontWeight.w500,
      //                             fontSize: 17,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
