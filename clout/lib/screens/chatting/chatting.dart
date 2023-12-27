import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

// widgets
import 'package:clout/widgets/header/header.dart';
import 'package:clout/screens/chatting/widgets/right_chat.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({super.key});

  @override
  State<ChattingPage> createState() => _ChattingState();
}

class _ChattingState extends State<ChattingPage> {
  final TextEditingController _controller =
      TextEditingController(); // 메시지 입력하는 input 컨트롤러
  final chatList = <ChatMessage>[]; // 채팅 메시지 저장할 리스트
  final scrollController = ScrollController(); // 채팅 화면 스크롤 하기 위한 컨트롤러
  String chatRoomId = "0"; // 현재 채팅방의 ID
  late StompClient stompClient; // Stomp 클라이언트를 나타내는 변수

  @override
  void initState() {
    super.initState();

    try {
      // Stomp 초기화 및 연결
      stompClient = StompClient(
        config: StompConfig(
          url: 'ws://3.35.132.84:8080/clout-websocket',
          onConnect: (StompFrame frame) {
            print('Stomp connected');
            // 채팅 메시지
            stompClient.subscribe(
              destination: '/topic/chats',
              callback: (frame) {
                // 수신 메시지 처리
                Map<String, dynamic> result = json.decode(frame.body!);
                String message = result['message'];
                String time = result['time'];
                addMessage(message, time);
              },
            );
          },
          onWebSocketError: (dynamic error) {
            print('WebSocket 연결 에러발생! 💨: $error');
          },
          stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
          webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
        ),
      );

      stompClient.activate();
    } catch (e) {
      print('Stomp client 에러발생! 💨: $e');
    }
  }

  // void onConnect(StompFrame frame) {
  //   stompClient.subscribe(
  //     destination: '/topic/chats',
  //     callback: (frame) {
  //       Map<String, dynamic> result = json.decode(frame.body!);
  //       String message = result['message'];
  //       String time = result['time'];
  //       addMessage(message, time);
  //     },
  //   );
  // }

  // final stompClient = StompClient(
  //   config: StompConfig(
  //     url: 'ws://3.35.132.84:8080/clout-websocket',
  //     onConnect: onConnect,
  //     beforeConnect: () async {
  //       print('waiting to connect...');
  //       await Future.delayed(const Duration(milliseconds: 200));
  //       print('connecting...');
  //     },
  //     onWebSocketError: (dynamic error) => print(error.toString()),
  //     stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
  //     webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  //   ),
  // );

  // void main() {
  //   stompClient.activate();
  // }

  // 채팅방 존재 여부 확인 및 처리하는 로직
  Future<void> checkOrCreateChatRoom() async {
    // 채팅방이 존재하는지 확인하기 위해 api 요청
    final response = await GetConnect().get(
      'http://3.35.132.84:8080/chats/$chatRoomId',
    );

    if (response.statusCode == 200) {
      // 채팅방ㅇㅣ 존재한다면 채팅방 상세 정보와 이전 채팅 목록 받아오기
      final responseBody = response.body as Map<String, dynamic>;
      final chatRoomId = responseBody['chatRoomId'];
      final advertisementId = responseBody['advertisementId'];
      final hostId = responseBody['hostId'];
      final guestId = responseBody['guestId'];
      final chatHistories = responseBody['chatHistories'] as List<dynamic>;

      for (final history in chatHistories) {
        final chatIdx = history['chatIdx'];
        final senderName = history['senderName'];
        final senderId = history['senderId'];
        final message = history['msg'];
        final dateTime = DateTime.parse(history['dateTime'] as String);
      }
    } else if (response.status.isNotFound) {
      // 기존 채팅방이 없는 경우, 새로운 채팅방 생성
      final newChatRoomId = await createChatRoom();
      setState(() {
        chatRoomId = newChatRoomId;
      });
    } else {
      throw Exception('채팅방 생성 실패 💨');
    }
  }

  // 새로운 채팅방 생성
  Future<String> createChatRoom() async {
    try {
      final requestBody = {
        // "hostId": '', 
        // "guestId": ,
      };

      final response = await GetConnect().post(
        'http://3.35.132.84:8080/chats',
        json.encode(requestBody),
        // json.encode({"hostId": 0, "guestId": 0}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.status.isOk) {
        // 생성된 채팅방 ID 반환
        final responseBody = response.body as Map<String, dynamic>;
        final chatRoomId = responseBody['chatRoomId'].toString();
        return chatRoomId;
      } else {
        throw Exception('Failed to create a chat room');
      }
    } catch (error) {
      throw Exception('Failed to create a chat room: $error');
    }
  }

  // 수신한 메시지 처리하고 화면에 추가
  void addMessage(String message, String time) {
    setState(() {
      chatList.insert(0, ChatMessage(message, time));
      scrollToBottom();
    });
  }

  // 화면 최하단으로 스크롤하는 함수
  void scrollToBottom() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.colors['white'],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Header(
          header: 1,
          headerTitle: '모카우유',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                reverse: true,
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  final message = chatList[index];
                  return RightChat(message.message, message.time);
                },
              ),
            ),
            SizedBox(height: 85),
          ],
        ),
      ),
      bottomSheet: Container(
        color: style.colors['white'],
        child: Padding(
          padding: EdgeInsets.all(15),
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
              hintText: "메시지를 입력하세요..",
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send,
                  size: 25,
                  color: style.colors['main1'],
                ),
                onPressed: _sendMessage,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: Color(0xFF979C9E))),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(width: 3, color: Color(0xFF927EFF)),
              ),
            ),
            // 엔터 키를 눌렀을 때 호출될 함수
            onFieldSubmitted: (_) {
              _sendMessage();
            },
          ),
        ),
      ),
    );
  }

  // 입력된 메시지 서버로 전송하기
  void _sendMessage() {
    final message = _controller.text;
    if (message.isNotEmpty) {
      String messageTime = DateFormat('HH:mm').format(DateTime.now());
      stompClient.send(
        destination: '/app/sendMessage',
        body: json.encode({'message': message, 'time': messageTime}),
      );
      _controller.clear();
    }
  }

  @override
  void dispose() {
    // 페이지 종료시 stomp 클라이언트 비활성화
    stompClient.deactivate();
    _controller.dispose();
    super.dispose();
  }
}

class ChatMessage {
  final String message;
  final String time;

  ChatMessage(this.message, this.time);
}
