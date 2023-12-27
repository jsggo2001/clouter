import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/utilities/my_scroll.dart';
import 'package:flutter/material.dart';

// widgets
import '../../widgets/header/header.dart';
import '../notification/widgets/notification_item_box.dart';

class Contract {
  String name = '모카우유';
  String image = '/assets/images/clouterImage.jpg';
}

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Contract contract = Contract();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: Header(
              header: 4,
              headerTitle: '알림 목록',
            )),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xffEBE7FF),
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(30),
              //   topRight: Radius.circular(30),
              // ),
            ),
            // padding: EdgeInsets.only(top: 10),
            child: BouncingListview(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  NotificationItem(
                    image: 'assets/images/clouterImage.jpg',
                    name: '모카우유',
                    result: 1,
                  ),
                  NotificationItem(
                      image: 'assets/images/itemImage.jpg',
                      name: '못골영농조합법인',
                      result: 0),
                  NotificationItem(
                      image: 'assets/images/clouter.png',
                      name: '춘식이귀여워',
                      result: -1),
                  NotificationItem(
                      image: 'assets/images/advertiser.png',
                      name: '광고주입니다',
                      result: -1),
                  NotificationItem(
                      image: 'assets/images/baby.png', name: 'A409', result: 1),
                  NotificationItem(
                      image: 'assets/images/itemImage.jpg',
                      name: '못골영농조합법인',
                      result: 1),
                  NotificationItem(
                    image: 'assets/images/clouterImage.jpg',
                    name: '모카우유',
                    result: -1,
                  ),
                ],
              ),
            )));
  }
}
