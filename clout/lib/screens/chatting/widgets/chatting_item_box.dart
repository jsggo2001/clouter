import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// screens
import 'package:clout/screens/chatting/chatting.dart';

class Chatting {
  String image = 'assets/images/clouterImage.jpg';
  String nickName = '모카우유';
  DateTime lastChatTime = DateTime.now();
  String lastMessage = '혹시 어떤 장난감인지 사이트나 사진인지 볼 수 있을까요~~?~~?~';
  int unreadMessages = 3;
}

class ChattingItemBox extends StatelessWidget {
  ChattingItemBox({super.key});

  // final Chatting chatting;
  Chatting chatting = Chatting();

  // 마지막 메시지 시간 포맷
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} 분전';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} 시간 전';
    } else {
      return '${date.year}.${date.month}.${date.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(() => ChattingPage());
        },
        child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 203, 203, 203),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipOval(
                  child: Image.asset(
                    chatting.image,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(chatting.nickName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        SizedBox(height: 3),
                        Text(chatting.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: style.colors['gray'],
                              overflow: TextOverflow.ellipsis,
                            )),
                      ]),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(formatDate(chatting.lastChatTime)),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: style.colors['main1'],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                      child: Text(
                        '${chatting.unreadMessages}',
                        style: TextStyle(
                          color: style.colors['white'],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
