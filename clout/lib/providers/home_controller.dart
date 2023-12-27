import 'dart:async';
import 'dart:convert';

import 'package:clout/hooks/apis/normal_api.dart';
import 'package:clout/type.dart';
import 'package:clout/utilities/category_translator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var scrollController = ScrollController().obs;

  Timer _timer = Timer(Duration(milliseconds: 3000), () {});

  @override
  void onInit() {
    scrollController.value.addListener(() {
      print(scrollController.value.position.pixels);
      if (scrollController.value.position.pixels < -100) {
        if (!_timer.isActive) {
          HapticFeedback.mediumImpact();
          scrollController.value.animateTo(0,
              duration: Duration(milliseconds: 2000), curve: Curves.easeInExpo);
          reload();
          _timer = Timer(Duration(milliseconds: 3000), () {});
        }
      }
    });
    super.onInit();
  }

  var campaignData = RxList<CampaignInfo>();
  var clouterData = RxList<ClouterInfo>();
  var isLoading = true;

  void fetchCampaigns() async {
    final NormalApi api = NormalApi();
    await Future.delayed(Duration(seconds: 2));
    var response = await api.getRequest(
        '/advertisement-service/v1/advertisements/', 'top10');
    // reponse = {'statusCode' : 값, 'body' : 값};

    var json = jsonDecode(response['body']);

    print(json);

    List<dynamic> campaignsJson = json['top10CampaignList'];
    if (campaignsJson != null) {
      campaignData.value = campaignsJson.map((item) {
        var campaign = Campaign.fromJson(item['campaign']);
        var advertiserInfo = AdvertiserInfo.fromJson(item['advertiserInfo']);
        var imageList = item['imageList'];
        isLoading = false;
        return CampaignInfo(
          campaignId: campaign.campaignId,
          adPlatformList: campaign.adPlatformList,
          price: campaign.price,
          details: campaign.details,
          deletedAt: campaign.deletedAt,
          title: campaign.title,
          adCategory:
              AdCategoryTranslator.translateAdCategory(campaign.adCategory!),
          isPriceChangeable: campaign.isPriceChangeable,
          isDeliveryRequired: campaign.isDeliveryRequired,
          numberOfRecruiter: campaign.numberOfRecruiter,
          numberOfApplicants: campaign.numberOfApplicants,
          numberOfSelectedMembers: campaign.numberOfSelectedMembers,
          offeringDetails: campaign.offeringDetails,
          sellingLink: campaign.sellingLink,
          applyStartDate: campaign.applyStartDate,
          applyEndDate: campaign.applyEndDate,
          minClouterAge: campaign.minClouterAge,
          maxClouterAge: campaign.maxClouterAge,
          minFollower: campaign.minFollower,
          companyInfo: advertiserInfo.companyInfo,
          address: advertiserInfo.address,
          advertiserInfo: advertiserInfo,
          imageList: imageList,
        );
      }).toList();
    } else {
      campaignData.value = [];
    }
    isLoading = false;
    update();
  }

  void fetchClouters() async {
    final NormalApi api = NormalApi();
    await Future.delayed(Duration(seconds: 2));
    var response =
        await api.getRequest('/member-service/v1/clouters/', 'top10');
    var json = jsonDecode(response['body']);

    List<dynamic> cloutersJson = json['clouters'];
    if (cloutersJson != null) {
      clouterData.value = cloutersJson.map((item) {
        var clouterInfo = ClouterInfo.fromJson(item);
        return ClouterInfo(
          clouterId: clouterInfo.clouterId,
          userId: clouterInfo.userId,
          avgScore: clouterInfo.avgScore,
          // clouterInfo.contractCount, // 💥 계약한 광고 건수 수정
          role: clouterInfo.role,
          nickName: clouterInfo.nickName,
          name: clouterInfo.name,
          birthday: clouterInfo.birthday,
          age: clouterInfo.age,
          phoneNumber: clouterInfo.phoneNumber,
          channelList: clouterInfo.channelList,
          minCost: clouterInfo.minCost,
          categoryList: clouterInfo.categoryList,
          regionList: clouterInfo.regionList,
          address: clouterInfo.address,
          countOfContract: clouterInfo.countOfContract,
          imageResponses: clouterInfo.imageResponses,
        );
      }).toList();
    } else {
      clouterData.value = [];
    }
    isLoading = false;
    update();
  }

  reload() async {
    campaignData.clear();
    clouterData.clear();
    isLoading = true;
    update();
    fetchCampaigns();
    fetchClouters();
  }
}
