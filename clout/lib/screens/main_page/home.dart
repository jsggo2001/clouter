// Global
import 'package:clout/type.dart';
import 'package:clout/widgets/loading_indicator.dart';
import 'package:clout/widgets/refreshable_container.dart';
import 'package:clout/widgets/sns/sns2.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

// utilities
import 'package:clout/utilities/bouncing_listview.dart';

// controllers
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:clout/providers/home_controller.dart';

// Screens
import 'package:clout/screens/main_page/widgets/menu_title.dart';

// Widgets
import 'package:clout/widgets/image_carousel.dart';
import 'package:clout/widgets/common/main_drawer.dart';
import 'package:clout/widgets/header/header.dart';
import 'package:clout/screens/main_page/widgets/main_carousel_text1.dart';
import 'package:clout/widgets/buttons/small_button.dart';
import 'package:clout/widgets/list/campaign_item_box.dart';
import 'package:clout/widgets/list/clouter_item_box.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final campaignData = <CampaignInfo>[].obs;
  // final clouterData = <ClouterInfo>[].obs;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    final HomeController homeController = Get.put(HomeController());
    homeController.fetchCampaigns();
    homeController.fetchClouters();
  }

  List<String> imgList = [
    'assets/images/main_carousel_1.jpg',
    'assets/images/clouterImage.jpg',
    'assets/images/itemImage.jpg',
    'assets/images/food.png',
  ];

  List<Widget> carouselList = [
    Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: Image.asset(
            'assets/images/main_carousel_1.jpg',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: FractionalOffset(0.5, 0.5),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    MainCarouselText1(
                      text: '자신의 콘텐츠와 브랜드와의',
                    ),
                    MainCarouselText1(
                      text: '적합성을 평가하여',
                    ),
                    MainCarouselText1(
                      text: '최적의 계약을 체결해보세요!',
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      width: 180,
                      child: SmallButton(
                        title: '캠페인 보러가기',
                      )),
                )
              ],
            ),
          ),
        ),
      ],
    ),
    Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: SizedBox(
            child: Image.asset(
              'assets/images/clouterImage.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
            alignment: FractionalOffset(0.5, 0.5),
            child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        MainCarouselText1(
                          text: '자신의 콘텐츠와 브랜드와의',
                        ),
                        MainCarouselText1(
                          text: '적합성을 평가하여',
                        ),
                        MainCarouselText1(
                          text: '최적의 계약을 체결해보세요!',
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 180,
                          child: SmallButton(
                            title: '캠페인 보러가기',
                          )),
                    )
                  ],
                )))
      ],
    ),
    Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: SizedBox(
            child: Image.asset(
              'assets/images/itemImage.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
            alignment: FractionalOffset(0.5, 0.5),
            child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        MainCarouselText1(
                          text: '자신의 콘텐츠와 브랜드와의',
                        ),
                        MainCarouselText1(
                          text: '적합성을 평가하여',
                        ),
                        MainCarouselText1(
                          text: '최적의 계약을 체결해보세요!',
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 180,
                          child: SmallButton(
                            title: '캠페인 보러가기',
                          )),
                    )
                  ],
                )))
      ],
    ),
    Stack(
      children: [
        Opacity(
          opacity: 0.6,
          child: SizedBox(
            child: Image.asset(
              'assets/images/food.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          alignment: FractionalOffset(0.5, 0.5),
          child: FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    MainCarouselText1(
                      text: '자신의 콘텐츠와 브랜드와의',
                    ),
                    MainCarouselText1(
                      text: '적합성을 평가하여',
                    ),
                    MainCarouselText1(
                      text: '최적의 계약을 체결해보세요!',
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 180,
                    child: SmallButton(
                      title: '캠페인 보러가기',
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    )
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        drawer: MyDrawer(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 0,
          ),
        ),
        body: RefreshableContainer(
          controller: controller.scrollController.value,
          child: Column(
            children: [
              Container(
                color: Colors.black,
                // height: 200,
                width: double.infinity,
                child: ImageCarousel(
                  imageSliders: carouselList,
                  aspectRatio: 0,
                  enlarge: false,
                ),
              ),
              Container(
                color: style.colors['white'],
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MenuTitle(text: '인기있는 클라우터', destination: 1),
                        controller.isLoading
                            ? SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(70),
                                  child: LoadingWidget(),
                                ))
                            : BouncingListview(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    children: controller.clouterData
                                        .map((clouterInfo) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 10, 5, 20),
                                        child: ClouterItemBox(
                                            clouterId:
                                                clouterInfo.clouterId ?? 0,
                                            userId: clouterInfo.userId ?? '',
                                            nickName:
                                                clouterInfo.nickName ?? '',
                                            avgScore: clouterInfo.avgScore ?? 0,
                                            minCost: clouterInfo.minCost ?? 0,
                                            countOfContract:
                                                clouterInfo.countOfContract ??
                                                    0,
                                            categoryList:
                                                clouterInfo.categoryList ??
                                                    [''],
                                            firstImg: clouterInfo
                                                            .imageResponses !=
                                                        null &&
                                                    clouterInfo.imageResponses!
                                                        .isNotEmpty
                                                ? ImageResponse.fromJson(
                                                        clouterInfo
                                                            .imageResponses?[0])
                                                    .path
                                                : '',
                                            adPlatformList:
                                                clouterInfo.channelList!
                                                    .map((e) => Sns2(
                                                          platform: e.platform,
                                                        ))
                                                    .toList()),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MenuTitle(text: '인기있는 캠페인', destination: 2),
                        controller.isLoading
                            ? SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(70),
                                  child: LoadingWidget(),
                                ))
                            : BouncingListview(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    children: controller.campaignData
                                        .map((campaignInfo) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 10, 5, 20),
                                        child: CampaignItemBox(
                                          campaignId:
                                              campaignInfo.campaignId ?? 0,
                                          adCategory:
                                              campaignInfo.adCategory ?? '',
                                          title: campaignInfo.title ?? '',
                                          price: campaignInfo.price ?? 0,
                                          companyInfo:
                                              campaignInfo.companyInfo!,
                                          numberOfSelectedMembers: campaignInfo
                                                  .numberOfSelectedMembers ??
                                              0,
                                          numberOfRecruiter:
                                              campaignInfo.numberOfRecruiter ??
                                                  0,
                                          firstImg:
                                              campaignInfo.imageList != null &&
                                                      campaignInfo
                                                          .imageList!.isNotEmpty
                                                  ? ImageResponse.fromJson(
                                                          campaignInfo
                                                              .imageList?[0])
                                                      .path
                                                  : '',
                                          adPlatformList:
                                              campaignInfo.adPlatformList!
                                                  .map((e) => Sns2(
                                                        platform: e,
                                                      ))
                                                  .toList(),
                                          advertiserInfo:
                                              campaignInfo.advertiserInfo!,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                      ],
                    )
                  ],
                ),
              ),
              userController.memberType == 0
                  ? SizedBox(height: 150)
                  : SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
