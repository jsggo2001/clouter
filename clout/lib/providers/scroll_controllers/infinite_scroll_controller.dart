import 'package:clout/widgets/header/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// api
import 'dart:convert';
import 'dart:async';
import 'package:clout/type.dart';
import 'package:clout/hooks/apis/authorized_api.dart';

// utilities
import 'package:clout/utilities/category_translator.dart';

// widgets
import 'package:clout/widgets/sns/sns2.dart';
import 'package:clout/widgets/list/campaign_item_box.dart';

class InfiniteScrollController extends GetxController {
  var scrollController = ScrollController().obs;

  List<dynamic> data = [].obs;

  int pageSize = 20;
  var isLoading = true;
  var dataLoading = true;
  var hasMore = true;
  var currentPage = 0;
  var endPoint = '';
  var parameter = '';
  var typeParam = '';
  var pageType = '';

  setTypeParam(input) {
    typeParam = input;
    update();
  }

  setEndPoint(input) {
    endPoint = input;
    update();
  }

  setParameter(input) {
    parameter = input;
    update();
  }

  setCurrentPage(input) {
    currentPage = input;
    update();
  }

  setIsLoading(input) {
    isLoading = input;
    update();
  }

  setPageType(input) {
    pageType = input;
    update();
  }

  // final userController = Get.find<UserController>();
  Timer _timer = Timer(Duration(milliseconds: 3000), () {});

  @override
  void onInit() {
    scrollController.value.addListener(() {
      print(scrollController.value.position.pixels);
      if (scrollController.value.position.pixels ==
              scrollController.value.position.maxScrollExtent &&
          hasMore) {
        setCurrentPage(currentPage + 1);
        getData();
      }
      if (scrollController.value.position.pixels < -100) {
        if (!_timer.isActive) {
          HapticFeedback.mediumImpact();
          reload();
          _timer = Timer(Duration(milliseconds: 3000), () {});
        }
      }
    });

    super.onInit();
  }

  getData() async {
    try {
      dataLoading = true;
      hasMore = true;
      update();
      print('여기까지 옴1');
      print('여기까지 옴2');
      final AuthorizedApi authorizedApi = AuthorizedApi();
      await setParameter(userController.memberType == -1
          ? '?clouterId=${userController.memberId}&page=$currentPage&size=${10}'
          : '?advertiserId=${userController.memberId}&page=$currentPage&size=${10}');
      await Future.delayed(Duration(milliseconds: 600));
      var response = await authorizedApi.getRequest(endPoint, parameter);
      print(response);
      var jsonData = jsonDecode(response['body']);
      var contentList = jsonData['content'] as List;

      var appendData = [];

      if (contentList.isNotEmpty) {
        print('여기까지 옴3');
        for (var item in contentList) {
          print('여기까지 옴4');
          print(contentList[0]);
          if (item.containsKey('applyId')) {
            var campaignData = ApplyContent.fromJson(item);
            // var imageList = item['imageList'];
            print('🌟 계약으로 오나..?');

            var campaignItemBox = Padding(
              padding: const EdgeInsets.all(10.0),
              child: CampaignItemBox(
                applyId: campaignData.applyId,
                campaignId: campaignData.campaignId,
                adCategory: AdCategoryTranslator.translateAdCategory(
                    campaignData.adCategory!),
                title: campaignData.title,
                price: campaignData.price,
                companyName: campaignData.companyName!,
                numberOfSelectedMembers: campaignData.numberOfSelectedMembers,
                numberOfRecruiter: campaignData.numberOfRecruiter,
                // firstImg: ImageResponse.fromJson(imageList[0]).path,
                advertiserAvgStar: campaignData.advertiserAvgStar,
                adPlatformList: campaignData.adPlatformList
                    ?.map((platform) => Sns2(platform: platform))
                    .toList(),
              ),
            );
            appendData.add(campaignItemBox);
          } else {
            var campaignData = CampaignInfo.fromJson(item['campaign']);
            var advertiserData =
                AdvertiserInfo.fromJson(item['advertiserInfo']);
            var imageList = item['imageList'];
            print('❌ 캠페인으로 가나..?');
            var campaignItemBox = Padding(
              padding: const EdgeInsets.all(10.0),
              child: CampaignItemBox(
                campaignId: campaignData.campaignId ?? 0,
                adCategory: AdCategoryTranslator.translateAdCategory(
                    campaignData.adCategory!),
                title: campaignData.title ?? "제목없음",
                price: campaignData.price ?? 0,
                companyInfo: advertiserData.companyInfo!,
                numberOfSelectedMembers:
                    campaignData.numberOfSelectedMembers ?? 0,
                numberOfRecruiter: campaignData.numberOfRecruiter ?? 0,
                firstImg: ImageResponse.fromJson(imageList[0]).path,
                adPlatformList: campaignData.adPlatformList
                        ?.map((platform) => Sns2(platform: platform))
                        .toList() ??
                    [],
                advertiserInfo: advertiserData,
              ),
            );
            appendData.add(campaignItemBox);
          }
        }
        data.addAll(appendData);
        dataLoading = false;
        isLoading = false;
        update();
      } else {
        dataLoading = false;
        isLoading = false;
        hasMore = false;
        update();
      }
    } catch (e) {
      print('오류발생');
      isLoading = false;
      dataLoading = false;
      hasMore = false;
      update();
      print(e);
    }
  }

  reload() async {
    await setIsLoading(true);
    dataLoading = true;
    hasMore = true;
    data.clear();
    update();
    await setCurrentPage(0);
    await Future.delayed(Duration(milliseconds: 100));

    await getData();
  }
}
