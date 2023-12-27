import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/screens/profile/clouter/widgets/available_platform.dart';
import 'package:clout/widgets/loading_indicator.dart';
import 'package:clout/utilities/category_translator.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// widgets
import 'package:clout/screens/mypage/widgets/selected_category.dart';
import 'package:clout/screens/campaign_register/widgets/data_title.dart';
import 'package:clout/screens/mypage/widgets/info_item_box.dart';
import 'package:clout/screens/mypage/widgets/update_button.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/header/header.dart';

// api
import 'dart:convert';
import 'package:clout/type.dart';

// controllers
import 'package:clout/providers/user_controllers/user_controller.dart';

class ClouterProfile extends StatefulWidget {
  const ClouterProfile({super.key});

  @override
  State<ClouterProfile> createState() => _ClouterProfileState();
}

class _ClouterProfileState extends State<ClouterProfile> {
  var clouterInfo;

  var _isLoading = true;

  final userController = Get.find<UserController>();

  Widget availablePlatforms = Row();
  Widget myImages = Container();

  @override
  void initState() {
    super.initState();
    _showDetail();
  }

  _showDetail() async {
    final AuthorizedApi authorizedApi = AuthorizedApi();

    var response = await authorizedApi.getRequest(
        '/member-service/v1/clouters/', userController.memberId);

    final decodedResponse = jsonDecode(response['body']);
    print(decodedResponse);

    List<Widget> platformIcons = [];
    List<Widget> images = [
      SizedBox(
        width: 20,
      )
    ];
    setState(() {
      clouterInfo = ClouterInfo.fromJson(decodedResponse);
      // 광고 가능 플랫폼 위젯 만드는 함수
      for (int i = 0; i < clouterInfo.channelList!.length; i++) {
        platformIcons.add(
          Expanded(
            child: AvailablePlatform(
              platform: clouterInfo.channelList![i].platform,
            ),
          ),
        );
      }
      availablePlatforms = Row(
        children: platformIcons,
      );

      // 내 사진들 위젯 만드는 함수
      for (int i = 0; i < clouterInfo.imageResponses!.length; i++) {
        images.add(
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(width: 1, color: style.colors['main1']!),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                ImageResponse.fromJson(clouterInfo.imageResponses[i]).path!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
        images.add(SizedBox(width: 20));
      }
      myImages = BouncingListview(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: images,
        ),
      );
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Header(
          header: 4,
          headerTitle: '내 프로필',
        ),
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: BouncingListview(
          child: Column(
            children: [
              FractionallySizedBox(
                  widthFactor: 0.9,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('회원 정보',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              UpdateButton(),
                            ],
                          ),
                        ),
                        Divider(
                            thickness: 1,
                            height: 1,
                            color: style.colors['lightgray']),
                        _isLoading
                            ? Column(
                                children: [
                                  InfoItemBox(
                                      titleName: '닉네임', contentInfo: ''),
                                  InfoItemBox(titleName: '이름', contentInfo: ''),
                                  InfoItemBox(
                                      titleName: '연락처', contentInfo: ''),
                                  InfoItemBox(
                                      titleName: '생년월일', contentInfo: ''),
                                  InfoItemBox(titleName: '나이', contentInfo: ''),
                                  InfoItemBox(titleName: '주소', contentInfo: ''),
                                ],
                              )
                            : Column(
                                children: [
                                  InfoItemBox(
                                      titleName: '닉네임',
                                      contentInfo: clouterInfo?.nickName ?? ''),
                                  InfoItemBox(
                                      titleName: '이름',
                                      contentInfo: clouterInfo?.name ?? ''),
                                  InfoItemBox(
                                      titleName: '연락처',
                                      contentInfo:
                                          clouterInfo?.phoneNumber ?? ''),
                                  InfoItemBox(
                                      titleName: '생년월일',
                                      contentInfo: clouterInfo?.birthday ?? ''),
                                  InfoItemBox(
                                      titleName: '나이',
                                      contentInfo:
                                          clouterInfo?.age.toString() ?? ''),
                                  InfoItemBox(
                                      titleName: '주소',
                                      contentInfo:
                                          '(${clouterInfo?.address!.zipCode!}) ${clouterInfo?.address!.mainAddress!} ${clouterInfo?.address!.detailAddress!}'),
                                ],
                              ),
                        SizedBox(height: 30),
                        DataTitle(text: '내 사진'),
                        SizedBox(height: 10),
                      ])),
              _isLoading
                  ? SizedBox(height: 50, child: LoadingWidget())
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: myImages,
                    ),
              FractionallySizedBox(
                widthFactor: 0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    DataTitle(text: '광고 희망 플랫폼'),
                    SizedBox(height: 10),
                    availablePlatforms,
                    SizedBox(height: 20),
                    DataTitle(text: '희망 광고비'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${clouterInfo?.minCost!}원 ~ ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: style.colors['main1'],
                            )),
                        SizedBox(width: 10),
                        Text('points',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                    SizedBox(height: 20),
                    DataTitle(text: '희망 카테고리'),
                    BouncingListview(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var category
                                in clouterInfo?.categoryList ?? [])
                              SelectedCategory(
                                  title:
                                      AdCategoryTranslator.translateAdCategory(
                                          category)),
                          ],
                        )),
                    SizedBox(height: 20),
                    DataTitle(text: '희망 지역'),
                    BouncingListview(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (var region in clouterInfo?.regionList ?? [])
                            SelectedCategory(
                                title: AdCategoryTranslator.translateRegion(
                                    region)),
                        ],
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 💥 선택한 지역, 카테고리, 사진, 협상여부, 팔로워 수 추가하기
