import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:clout/screens/login/logout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// widgets
import 'package:clout/widgets/common/nametag.dart';

// controller

class MyDrawer extends StatefulWidget {
  @override
  MyDrawerState createState() => MyDrawerState();
}

class MyDrawerState extends State<MyDrawer> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              color: style.colors['white'],
              child: Container(
                decoration: BoxDecoration(
                  color: style.colors['main3'],
                  border: Border.symmetric(
                    horizontal:
                        BorderSide(width: 1, color: style.colors['category']!),
                  ),
                ),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          logout();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.logout, color: style.colors['category']),
                            Text('  로그아웃')
                          ],
                        ),
                      ),
                    ),
                    Container(
                        color: style.colors['main2'], height: 25, width: 0.3),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.settings_outlined,
                              color: style.colors['category']),
                          Text('  설정')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Wrap(
                // padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                        color: style.colors['main3'],
                        border: Border(
                            bottom: BorderSide(
                                color: style.colors['main2']!, width: 0.1))),
                    child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NameTag(
                                  title: userController.memberType == -1
                                      ? '클라우터'
                                      : '광고주'),
                              SizedBox(height: 3),
                              InkWell(
                                onTap: () => Get.toNamed(
                                    userController.memberType == -1
                                        ? '/cloutermypage'
                                        : '/advertisermypage'),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(' 님',
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    Icon(
                                      Icons.chevron_right,
                                    ),
                                  ],
                                ),
                              )
                            ])),
                  ),
                  ListTile(
                    title: Text('내 계약서', style: style.textTheme.headlineSmall),
                    onTap: () {
                      Get.toNamed('/contractlist');
                      Scaffold.of(context).closeDrawer();
                    },
                    trailing: Icon(Icons.chevron_right),
                  ),
                  if (userController.memberType == -1)
                    ListTile(
                      title:
                          Text('신청한 캠페인', style: style.textTheme.headlineSmall),
                      onTap: () {
                        Get.toNamed('/cloutermycampaign');
                        Scaffold.of(context).closeDrawer();
                      },
                      trailing: Icon(Icons.chevron_right),
                    )
                  else if (userController.memberType == 1)
                    ListTile(
                      title:
                          Text('내 캠페인', style: style.textTheme.headlineSmall),
                      onTap: () {
                        Get.toNamed('/advertisermycampaign');
                        Scaffold.of(context).closeDrawer();
                      },
                      trailing: Icon(Icons.chevron_right),
                    ),
                  if (userController.memberType == -1)
                    ListTile(
                      title: Text('관심있는 캠페인',
                          style: style.textTheme.headlineSmall),
                      onTap: () {
                        Get.toNamed('/clouterlikedcampaign');
                        Scaffold.of(context).closeDrawer();
                      },
                      trailing: Icon(Icons.chevron_right),
                    )
                  else if (userController.memberType == 1)
                    ListTile(
                      title: Text('관심있는 클라우터',
                          style: style.textTheme.headlineSmall),
                      onTap: () {
                        Get.toNamed('/advertiserlikedclouter');
                        Scaffold.of(context).closeDrawer();
                      },
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ExpansionTile(
                    iconColor: style.colors['main1'],
                    textColor: style.colors['main1'],
                    tilePadding: EdgeInsets.only(right: 15),
                    title: ListTile(
                      title:
                          Text('포인트 관리', style: style.textTheme.headlineSmall),
                    ),
                    children: [
                      if (userController.memberType == -1)
                        ListTile(
                          tileColor: style.colors['main3'],
                          title:
                              Text('포인트 출금', style: style.textTheme.bodyLarge),
                          onTap: () {
                            Get.toNamed('/withdrawfirst');
                            Scaffold.of(context).closeDrawer();
                          },
                        )
                      else if (userController.memberType == 1)
                        ListTile(
                          tileColor: style.colors['main3'],
                          title:
                              Text('포인트 충전', style: style.textTheme.bodyLarge),
                          onTap: () {
                            Get.toNamed('/');
                            Scaffold.of(context).closeDrawer();
                          },
                        ),
                      if (userController.memberType == -1)
                        ListTile(
                          tileColor: style.colors['main3'],
                          title:
                              Text('포인트 내역', style: style.textTheme.bodyLarge),
                          onTap: () {
                            Get.toNamed('/clouterpointlist');
                            Scaffold.of(context).closeDrawer();
                          },
                        )
                      else if (userController.memberType == 1)
                        ListTile(
                          tileColor: style.colors['main3'],
                          title:
                              Text('포인트 내역', style: style.textTheme.bodyLarge),
                          onTap: () {
                            Get.toNamed('/advertiserpointlist');
                            Scaffold.of(context).closeDrawer();
                          },
                        ),
                    ],
                  ),
                  ListTile(
                    title: Text('이용약관'),
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    trailing: Icon(Icons.chevron_right),
                  ),
                  ListTile(
                    title: Text('개인정보처리방침'),
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                    },
                    trailing: Icon(Icons.chevron_right),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
