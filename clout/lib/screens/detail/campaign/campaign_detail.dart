import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// api
import 'dart:convert';
import 'package:clout/type.dart';
import 'package:clout/utilities/like_utils.dart';
import 'package:clout/hooks/apis/normal_api.dart';
import 'package:clout/hooks/apis/authorized_api.dart';

// controllers
import 'package:clout/providers/user_controllers/user_controller.dart';

// widgets
import 'package:clout/screens/detail/campaign/widgets/campaign_detail_content.dart';
import 'package:clout/screens/detail/campaign/widgets/campaign_detail_delivery_info.dart';
import 'package:clout/screens/detail/campaign/widgets/campaign_detail_info_box.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/buttons/like_button.dart';
import 'package:clout/widgets/header/header.dart';
import 'package:clout/widgets/image_carousel.dart';
import 'package:clout/screens/detail/campaign/widgets/campaign_detail_visit.dart';
import 'package:clout/widgets/common/custom_snackbar.dart';
import 'package:clout/widgets/loading_indicator.dart';

String caution =
    '✔ 리뷰 작성기간 미준수시 패널티(제품 비용, 체험 비용 환불 등) 및 계약서에 의거 법적 처벌을 받을 수 있습니다.\n✔ 캠페인 요구사항 및 가이드라인을 확인해서 작성해주시기 바랍니다.\n✔ 수집된 개인정보는 체험단 운영 및 경품 증정 등의 필수 목적으로 사용되고 그 외에 목적으로는 사용되지 않습니다.\n✔ 작성해 주신 리뷰/포스팅/콘텐츠는 최소 6개월 이상 유지를 원칙으로 합니다.\n✔ 제품 발송은 최초 가입 시 등록한 주소지로 발송됩니다.\n✔ 주소 이전 시 회원 정보 미반영으로 인한 피해는 당사에서 책임지지 않습니다.';

//////////////////////////////////////////////////////////////////////////////

class CampaignDetail extends StatefulWidget {
  CampaignDetail({super.key});

  @override
  State<CampaignDetail> createState() => _CampaignDetailState();
}

class _CampaignDetailState extends State<CampaignDetail> {
  CampaignInfo? campaignInfo;
  AdvertiserInfo? advertiserInfo;
  bool isLoading = true;
  bool isItemLiked = false;
  var imageSliders;
  int? applyId;
  bool? applyCheck;

  @override
  void initState() {
    super.initState();
    _showDetail();
    applycheck();
  }

  final userController = Get.find<UserController>();

  var campaignId = Get.arguments; // campaign_item_box에서 argument 가져오기

  final AuthorizedApi authorizedApi = AuthorizedApi();

  // 신청한 캠페인인지 확인하는 api
  applycheck() async {
    var response = await authorizedApi.getRequest(
        '/advertisement-service/v1/applies/applyCheck?',
        'advertisementId=$campaignId&clouterId=${userController.memberId}');

    var decodedResponse = jsonDecode(response['body']);
    applyId = decodedResponse['applyId'];
    applyCheck = decodedResponse['applyCheck'];
  }

  _showDetail() async {
    // item 정보 api 호출
    final NormalApi api = NormalApi();

    List<String> imgList = [];

    var response = await api.getRequest(
        '/advertisement-service/v1/advertisements/', campaignId);
    // reponse = {'statusCode' : 값, 'body' : 값}

    var bookmarkResponse;
    if (userController.memberType == -1) {
      bookmarkResponse = await authorizedApi.getRequest(
          '/member-service/v1/bookmarks/check',
          '?memberId=${userController.memberId}&targetId=$campaignId');
    }

    if (response != null) {
      print(CampaignResponse.fromJson(jsonDecode(response['body'])));
      var decodedResponse = jsonDecode(response['body']);

      // 이미지 슬라이더에 이미지 넣는 작업
      for (var imgInfo in decodedResponse['imageList']) {
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

      // 데이터를 모델 클래스에 매핑
      setState(() {
        campaignInfo = CampaignResponse.fromJson(decodedResponse).campaignInfo;
        advertiserInfo =
            CampaignResponse.fromJson(decodedResponse).advertiserInfo;
      });
      // ux 향상을 위해 의도적으로 0.7초 딜레이
      await Future.delayed(Duration(milliseconds: 700));
      setState(() {
        isLoading = false;
      });
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
      isLoading = false;
    });
  }

  // 캠페인 삭제 api
  deleteCampaign() async {
    var response = await authorizedApi.postRequest(
        '/advertisement-service/v1/advertisements/$campaignId', '');
    print(response);
    print(campaignId);
    if (response['statusCode'] == 200) {
      print('캠페인 삭제 성공~~🎉');
      Get.back();
      CustomSnackbar(
              title: '캠페인 삭제 완료!',
              message1: '캠페인이 삭제되었어요. 😥',
              message2: '새로운 캠페인으로 다시 만나요! 👍')
          .show();

      Get.toNamed('/home');
    } else {
      print('캠페인 삭제 실패.. ❌');
    }
  }

  endCampaign() async {
    var response = await authorizedApi.postRequest(
        '/advertisement-service/v1/advertisements/$campaignId/end', '');

    if (response['statusCode'] == 200) {
      print('캠페인 모집 종료 성공 ~~ 🎉');
      Get.back();

      CustomSnackbar(
              title: '캠페인 모집 종료!',
              message1: '캠페인 모집이 종료되었어요. 😊',
              message2: '새로운 캠페인으로 또 만나요! 👍')
          .show();

      Get.toNamed('/home');
    } else {
      print('캠페인 모집 종료 실패.. ❌');
    }
  }

  showBottomSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        height: 220,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              trailing: Icon(Icons.edit),
              title: Text('수정하기'),
              onTap: () {},
            ),
            Container(color: Colors.grey, width: double.infinity, height: 0.5),
            ListTile(
              trailing: Icon(Icons.delete_forever_rounded),
              title: Text('삭제하기'),
              onTap: () {
                deleteCampaign();
              },
            ),
            Container(color: Colors.grey, width: double.infinity, height: 0.5),
            ListTile(
              trailing: Icon(Icons.close),
              title: Text('모집 종료하기'),
              onTap: () {
                endCampaign();
              },
            ),
          ],
        ),
      ),
    );
  }

  cancelRegister() async {
    var response = await authorizedApi.postRequest(
        '/advertisement-service/v1/applies/$applyId/cancel', '');

    if (response['statusCode'] == 200) {
      print('캠페인 신청 취소 성공 ~~ 🎉');

      CustomSnackbar(
              title: '캠페인 신청 취소 완료!',
              message1: '캠페인 신청이 취소되었습니다. 😥',
              message2: '새로운 캠페인으로 다시 만나요! 👍')
          .show();
    } else {
      print('캠페인 신청 취소 실패.. ❌');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: style.colors['white'],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Header(
          header: 3,
          headerTitle: campaignInfo?.title,
        ),
      ),
      body: isLoading
          ? SizedBox(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                    child: LoadingWidget(),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '캠페인 정보를 불러오는 중입니다.\n잠시만 기다려 주세요',
                    textAlign: TextAlign.center,
                    style: style.textTheme.headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 200),
                ],
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  BouncingListview(
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          userController.memberType != -1
                              ? SizedBox(height: 20)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Like'),
                                    LikeButton(
                                      isLiked: isItemLiked,
                                      onTap: () {
                                        setState(() {
                                          isItemLiked = !isItemLiked;
                                        });
                                        if (campaignInfo != null &&
                                            campaignInfo!.campaignId != null) {
                                          sendLikeStatus(
                                            userController.memberId,
                                            campaignInfo!.campaignId!,
                                            isItemLiked,
                                            false,
                                          );
                                        } else {
                                          print("Campaign 정보 에러 ❌ ");
                                        }
                                      },
                                    )
                                  ],
                                ),
                          // 사진 캐러셀
                          ImageCarousel(
                              imageSliders: imageSliders,
                              infiniteScroll: imageSliders.length > 1,
                              aspectRatio: 1.2,
                              enlarge: true),
                          SizedBox(height: 20),
                          // 캠페인 정보 상자
                          if (campaignInfo != null && advertiserInfo != null)
                            CampaignDetailInfoBox(
                                campaignInfo: campaignInfo!,
                                advertiserInfo: advertiserInfo!),
                          SizedBox(height: 20),
                          campaignInfo != null
                              ? campaignInfo!.isDeliveryRequired!
                                  ? CampaignDetailContent(
                                      title: '협찬 제공 방법',
                                      content: CampaignDetailDeliveryInfo())
                                  : CampaignDetailContent(
                                      title: '협찬 제공 방법',
                                      content: CampaignDetailVisit())
                              : Container(),
                          CampaignDetailContent(
                            title: '제공 내역',
                            content: Text(
                              campaignInfo!.details!,
                              style: style.textTheme.bodyLarge,
                            ),
                          ),
                          CampaignDetailContent(
                            title: '요구사항',
                            content: Text(
                              campaignInfo!.offeringDetails!,
                              style: style.textTheme.bodyLarge,
                            ),
                          ),
                          CampaignDetailContent(
                            title: '주의사항',
                            content: Text(
                              caution,
                              style: style.textTheme.bodyLarge,
                            ),
                          ),
                          SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ),
                  userController.memberType == -1
                      ? Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: SizedBox(
                            height: 50,
                            child: applyCheck == false
                                ? BigButton(
                                    title:
                                        '신청하기', // 이미 지원한 캠페인일 경우 title 다르게 설정하고 버튼 비활성화 해야함
                                    function: () => Get.toNamed(
                                        '/applycampaign',
                                        arguments: campaignInfo?.campaignId),
                                  )
                                : BigButton(
                                    title: '신청 취소하기',
                                    function: () {
                                      cancelRegister();
                                    }),
                          ),
                        )
                      : userController.memberType == 1
                          ? Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: SizedBox(
                                      height: 50,
                                      child: BigButton(
                                        title: '신청자 목록보기',
                                        function: () => Get.toNamed(
                                            '/clouterselect',
                                            arguments: campaignId),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 50,
                                      child: ElevatedButton(
                                        // 편집 삭제 bottomSheetModal 띄우는 함수 넣어야 함
                                        onPressed: showBottomSheet,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              style.colors['category'],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.all(0),
                                        ),
                                        child: Icon(
                                          Icons.more_vert_outlined,
                                          color: style.colors['main1'],
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          : Container(),
                ],
              ),
            ),
    );
  }
}
