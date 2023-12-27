// Global
import 'package:clout/screens/mypage/advertiser/advertiser_mycampaign.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

//notification
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Screens
import 'screens/landing/landing.dart';
import 'package:clout/screens/login/login.dart';
import 'package:clout/screens/join_select/join_page.dart';
import 'package:clout/screens/main_page/main_page.dart';
import 'package:clout/screens/notification/notification.dart';
import 'package:clout/screens/review_register/review_complete.dart';
import 'package:clout/screens/chatting/chatting_list.dart';
import 'package:clout/screens/point/clouter_point_list.dart';
import 'package:clout/screens/mypage/clouter/clouter_mypage.dart';
import 'package:clout/screens/mypage/advertiser/advertiser_mypage.dart';
import 'package:clout/screens/profile/advertiser/advertiser_profile.dart';
import 'package:clout/screens/profile/clouter/clouter_profile.dart';
import 'package:clout/screens/point/withdraw/withdraw_first.dart';
import 'package:clout/screens/point/withdraw/withdraw_second.dart';
import 'package:clout/screens/point/withdraw/withdraw_complete.dart';
import 'package:clout/screens/campaign_register/campaign_register.dart';
import 'package:clout/screens/detail/campaign/campaign_detail.dart';
import 'package:clout/screens/contract_list/contract_list.dart';
import 'package:clout/binding/app_binding.dart';
import 'package:clout/screens/mypage/clouter/clouter_likedcampaign.dart';
import 'package:clout/screens/mypage/clouter/clouter_mycampaign.dart';
import 'package:clout/screens/point/add/add_first.dart';
import 'package:clout/screens/point/add/add_second.dart';
import 'package:clout/screens/point/advertiser_point_list.dart';
import 'package:clout/screens/apply_campaign/apply_campaign.dart';
import 'package:clout/screens/detail/clouter/clouter_detail.dart';
import 'package:clout/screens/point/add/add_complete.dart';
import 'package:clout/screens/review_register/review_register.dart';
import 'package:clout/screens/clouter_select/clouter_select.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리.. ${message.notification!.body!}");
}

final List<String> imgList = [
  'assets/images/main_carousel_1.jpg',
  'assets/images/itemImage.jpg',
  'assets/images/clouterImage.jpg',
];
void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeNotification();
  await dotenv.load(fileName: 'assets/config/.env'); //✨✨✨ 중요~
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var messageString = "";

  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("내 디바이스 토큰: $token");
  }

  @override
  void initState() {
    getMyDeviceToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        print('notification 수신');
        print(notification);
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
        splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        // disabledColor: Colors.transparent,
      ),
      initialBinding: AppBinding(),
      getPages: [
        GetPage(name: '/', page: () => Landing()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/join', page: () => JoinPage()),
        GetPage(name: '/home', page: () => MainPage()),
        GetPage(name: '/campaignRegister', page: () => CampaignRegister()),
        GetPage(name: '/notification', page: () => NotificationPage()),
        GetPage(name: '/reviewcomplete', page: () => ReviewComplete()),
        GetPage(name: '/reviewregister', page: () => ReviewRegister()),
        GetPage(name: '/chattinglist', page: () => ChattingList()),
        GetPage(name: '/clouterpointlist', page: () => ClouterPointList()),
        GetPage(name: '/cloutermypage', page: () => ClouterMyPage()),
        GetPage(name: '/clouterprofile', page: () => ClouterProfile()),
        GetPage(name: '/campaignDetail', page: () => CampaignDetail()),
        GetPage(name: '/advertisermypage', page: () => AdvertiserMyPage()),
        GetPage(name: '/advertiserprofile', page: () => AdvertiserProfile()),
        GetPage(name: '/clouterdetail', page: () => ClouterDetail()),
        GetPage(name: '/withdrawfirst', page: () => WithdrawFirst()),
        GetPage(name: '/withdrawsecond', page: () => WithdrawSecond()),
        GetPage(name: '/withdrawcomplete', page: () => WithdrawComplete()),
        GetPage(name: '/contractlist', page: () => ContractList()),
        GetPage(
            name: '/clouterlikedcampaign', page: () => ClouterLikedCampaign()),
        GetPage(name: '/cloutermycampaign', page: () => ClouterMyCampaign()),
        GetPage(
            name: '/advertiserpointlist', page: () => AdvertiserPointList()),
        GetPage(name: '/clouterpointlist', page: () => ClouterPointList()),
        GetPage(name: '/addfirst', page: () => AddFirst()),
        GetPage(name: '/addsecond', page: () => AddSecond()),
        GetPage(name: '/addcomplete', page: () => AddComplete()),
        GetPage(name: '/applycampaign', page: () => ApplyCampaign()),
        GetPage(name: '/clouterselect', page: () => ClouterSelect()),
        GetPage(
            name: '/advertisermycampaign', page: () => AdvertiserMycampaign()),
      ],
    );
  }
}
