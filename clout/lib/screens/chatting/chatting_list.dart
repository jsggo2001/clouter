import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// utilties
import 'package:clout/utilities/bouncing_listview.dart';

// widgets
import 'package:clout/screens/chatting/widgets/chatting_item_box.dart';
import 'package:clout/widgets/common/main_drawer.dart';
import 'package:clout/widgets/header/header.dart';

class ChattingList extends StatefulWidget {
  const ChattingList({super.key});

  @override
  State<ChattingList> createState() => _ChattingListState();
}

class _ChattingListState extends State<ChattingList> {
  final chatList = List<Map<String, dynamic>>.empty().obs;
  final api = GetConnect();

  // @override
  // void onInit() {
  //   super.onInit();
  //   // API 호출
  //   fetchChatList();
  // }

  // API 호출 메소드
  void fetchChatList() async {
    final response = await api.get('/chats?user={userId}');

    if (response.status.hasError) {
      // 에러 처리
      print('⛔ API 호출 중 오류 발생..: ${response.statusText}');
    } else {
      // 응답 처리
      final data = response.body;
      // 응답 데이터 chatList에 추가
      chatList.assignAll(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: style.colors['white'],
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 1,
            headerTitle: '채팅 목록', // 채널명 또는 계정명
          )),
      body:
          // Obx(() {
          //   return ListView.builder(
          //       itemCount: chatList.length,
          //       itemBuilder: (context, index) {
          //         final itemData = chatList[index];
          //         return ChattingItemBox(
          //             // chatting: Chatting(
          //             //     image: itemData['image'],
          //             //     nickname: itemData['nickname'],
          //             //     lastChatTime: itemData['lastChatTime'],
          //             //     lastMessage: itemData['lastMessage'],
          //             //     unreadMessages: itemData['unreadMessages'],
          //             //     ),
          //             );
          //       });
          // }
          Container(
              color: Colors.white,
              width: double.infinity,
              child: BouncingListview(
                  child: Column(children: [
                ChattingItemBox(),
                ChattingItemBox(),
                ChattingItemBox(),
              ]))),
    );
  }
}
