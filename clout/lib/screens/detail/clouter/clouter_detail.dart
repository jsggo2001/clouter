import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

// api
import 'package:get/get.dart';
import 'dart:convert';
import 'package:clout/type.dart';
import 'package:clout/utilities/like_utils.dart';
import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/hooks/apis/normal_api.dart';

// utility
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/utilities/category_translator.dart';

// widgets
import 'package:clout/widgets/sns/widgets/sns_item_box.dart';
import 'package:clout/widgets/image_carousel.dart';
import 'package:clout/widgets/header/header.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/buttons/like_button.dart';
import 'package:clout/screens/chatting/widgets/chatting_item_box.dart';
import 'package:clout/widgets/loading_indicator.dart';

// screen
import 'package:clout/screens/chatting/chatting_list.dart';

// controller
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:intl/intl.dart';

class ClouterDetail extends StatefulWidget {
  const ClouterDetail({super.key});

  @override
  State<ClouterDetail> createState() => _ClouterDetailState();
}

class _ClouterDetailState extends State<ClouterDetail> {
  ClouterInfo? clouterInfo;
  var clouterId = Get.arguments;
  var imageSliders;
  var f = NumberFormat('###,###,###,###,###');

  final userController = Get.find<UserController>();
  bool _isLoading = true;

  @override
  void initState() {
    _showDetail();
    super.initState();
  }

  doChat(destination) {
    // 채팅방 이동
    Get.to(() => ChattingList());
  }

  bool isItemLiked = false;

  _showDetail() async {
    final NormalApi normalApi = NormalApi();
    final AuthorizedApi authorizedApi = AuthorizedApi();

    List<String> imgList = [];
    var campaignResponse;
    if (userController.memberType == 0) {
      await normalApi.getRequest(
          '/member-service/v1/clouters/noneAuth/', clouterId);
      print(campaignResponse);
    } else {
      campaignResponse = await authorizedApi.getRequest(
          '/member-service/v1/clouters/', clouterId);
    }
    print(campaignResponse);
    var bookmarkResponse;
    if (userController.memberType != 0) {
      bookmarkResponse = await authorizedApi.getRequest(
          '/member-service/v1/bookmarks/check',
          '?memberId=${userController.memberId}&targetId=$clouterId');
    }

    if (campaignResponse != null) {
      final decodedResponse = jsonDecode(campaignResponse['body']);
      print(decodedResponse);
      print(decodedResponse['imageResponses']);

      // 이미지 슬라이더에 이미지 넣는 작업
      for (var imgInfo in decodedResponse['imageResponses']) {
        imgList.add(ImageResponse.fromJson(imgInfo).path!);
      }
      if (imgList.isEmpty) {
        imgList.add('assets/images/blank-profile.png');
        imageSliders = imgList
            .map((item) => Padding(
                  padding: const EdgeInsets.all(0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      child: Image.asset(item, fit: BoxFit.cover)),
                ))
            .toList();
      } else {
        imageSliders = imgList
            .map(
              (item) => Padding(
                padding: const EdgeInsets.all(0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    item,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
            .toList();
      }
      print(imageSliders.length);
      print(imgList);

      setState(() {
        clouterInfo = ClouterInfo.fromJson(decodedResponse);
      });
    } else {
      print('clouter detail 에러 ❌.');
    }

    if (bookmarkResponse != null) {
      final decodedResponse = jsonDecode(bookmarkResponse['body']);
      print(decodedResponse);
      setState(
        () {
          if (decodedResponse['check'] == null) {
            isItemLiked = false;
          } else {
            isItemLiked = decodedResponse['check'];
          }
        },
      );
    } else {
      print('clouter bookmark 여부 불러오기 실패 ❌');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.colors['white'],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Header(
          header: 3,
          headerTitle: clouterInfo?.nickName ?? '', // 채널명 또는 계정명
        ),
      ),
      body: _isLoading
          ? SizedBox(
              height: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    left: 160,
                    right: 160,
                    top: 0,
                    bottom: 280,
                    child: SizedBox(
                      height: 100,
                      child: LoadingWidget(),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 100,
                    child: Align(
                      child: Text(
                        '클라우터 정보를 불러오는 중입니다.\n잠시만 기다려 주세요',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned.fill(
                    child: BouncingListview(
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.star, color: Colors.amber),
                                    SizedBox(width: 3),
                                    Text(
                                        clouterInfo?.avgScore.toString() ?? '0',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800)),
                                  ],
                                ),
                                if (userController.memberType == 1)
                                  Row(
                                    children: [
                                      Text('Like'),
                                      LikeButton(
                                        isLiked: isItemLiked,
                                        onTap: () {
                                          setState(() {
                                            isItemLiked = !isItemLiked;
                                          });
                                          if (clouterInfo != null &&
                                              clouterInfo!.clouterId != null) {
                                            sendLikeStatus(
                                              userController.memberId,
                                              clouterInfo!.clouterId!,
                                              isItemLiked,
                                              true,
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  )
                              ],
                            ),
                            // 사진 캐러셀
                            ImageCarousel(
                              imageSliders: imageSliders,
                              aspectRatio: 1.2,
                              enlarge: true,
                              infiniteScroll: imageSliders.length > 1,
                            ),
                            SizedBox(height: 20),
                            Container(
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('희망 광고비',
                                            style: TextStyle(fontSize: 15)),
                                        Row(
                                          children: [
                                            Text(f.format(clouterInfo?.minCost),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        style.colors['logo'])),
                                            Text(' points'),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('계약한 광고 수',
                                            style: TextStyle(fontSize: 15)),
                                        Row(
                                          children: [
                                            Text(
                                                clouterInfo!.countOfContract
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        style.colors['logo'])),
                                            Text(' 건',
                                                style: TextStyle(fontSize: 15)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('희망 카테고리',
                                            style: TextStyle(fontSize: 15)),
                                        SizedBox(height: 5),
                                        Wrap(
                                          runSpacing: 5,
                                          spacing: 3,
                                          children: clouterInfo?.categoryList !=
                                                  null
                                              ? clouterInfo!.categoryList!
                                                  .map((category) => Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 8),
                                                      decoration: BoxDecoration(
                                                          color: style.colors[
                                                              'category'],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      child: Text(
                                                        AdCategoryTranslator
                                                            .translateAdCategory(
                                                                category),
                                                        style: TextStyle(
                                                            height: 1.2),
                                                      )))
                                                  .toList()
                                              : [Container()],
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       flex: 1,
                                //       child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceAround,
                                //         children: [
                                // Text('희망 광고비',
                                //     style: TextStyle(fontSize: 15)),
                                // Text('계약한 광고 수',
                                //     style: TextStyle(fontSize: 15)),
                                // Text('희망 카테고리',
                                //     style: TextStyle(fontSize: 15)),
                                //         ],
                                //       ),
                                //     ),
                                //     Expanded(
                                //       flex: 1,
                                //       child: Column(
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceAround,
                                //         children: [
                                //           Row(
                                //             children: [
                                // Text(
                                //     clouterInfo?.minCost
                                //             .toString() ??
                                //         '',
                                //     style: TextStyle(
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.w700,
                                //         color:
                                //             style.colors['logo'])),
                                // Text(' points'),
                                //             ],
                                //           ),
                                //           Row(
                                //             children: [
                                // Text(
                                //     clouterInfo!.countOfContract
                                //         .toString(),
                                //     style: TextStyle(
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.w700,
                                //         color:
                                //             style.colors['logo'])),
                                // Text(' 건',
                                //     style: TextStyle(fontSize: 15)),
                                //             ],
                                //           ),
                                // Text(
                                //     clouterInfo?.categoryList != null
                                //         ? clouterInfo!.categoryList!
                                //             .map((category) =>
                                //                 AdCategoryTranslator
                                //                     .translateAdCategory(
                                //                         category))
                                //             .join(', ')
                                //         : '',
                                //     style: TextStyle(
                                //         fontSize: 15,
                                //         fontWeight: FontWeight.w700,
                                //         color: style.colors['logo'])),
                                //         ],
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft, // 왼쪽으로 정렬
                                child: Text(
                                  'SNS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                            // 여러개 SNS 정보 반복해서 생성
                            clouterInfo?.channelList != null
                                ? Column(
                                    children: clouterInfo!.channelList!
                                        .map((e) => SnsItemBox(
                                            username: e.name,
                                            followers: e.followerScale,
                                            snsType: e.platform,
                                            snsUrl: e.link))
                                        .toList(),
                                  )
                                : Container(),
                            SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  ),
                  userController.memberType != 1
                      ? Container()
                      : Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Container(
                            color: Colors.transparent,
                            child: SizedBox(
                              height: 50,
                              child: BigButton(
                                title: '채팅하기',
                                function: () => Get.to(Chatting()),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
    );
  }
}
