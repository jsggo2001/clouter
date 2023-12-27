import 'package:clout/providers/age_controller.dart';
import 'package:clout/providers/fee_controller.dart';
import 'package:clout/providers/follower_controller.dart';
import 'package:clout/providers/image_picker_controller.dart';
import 'package:clout/providers/platform_select_controller.dart';
import 'package:clout/providers/region_controller.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:clout/type.dart';
import 'package:get/get.dart';

class CampaignRegisterController extends GetxController {
  var category,
      campaignTitle,
      recruitCount = 1,
      offeringItems,
      itemDetail,
      signature,
      link;

  bool isBlank = true;
  bool payPositive = false;
  bool deliveryPositive = false;

  final ageController = Get.put(
    AgeController(),
    tag: 'campaignRegister',
  );
  final platformController = Get.put(
    PlatformSelectController(),
    tag: 'campaignRegister',
  );
  final payController = Get.put(
    FeeController(),
    tag: 'campaignRegister',
  );
  final followerController = Get.put(
    FollowerController(),
    tag: 'campaignRegister',
  );
  final regionController = Get.put(
    RegionController(),
    tag: 'campaignRegister',
  );
  final imagePickerController = Get.put(
    ImagePickerController(),
    tag: 'campaignRegister',
  );
  final userController = Get.find<UserController>();

  var campaign;

  setCampaign() {
    List<String> platformList = [];
    for (int i = 0; i < 3; i++) {
      if (platformController.platforms[i]) {
        if (i == 0) {
          platformList.add('INSTAGRAM');
        } else if (i == 1) {
          platformList.add('TIKTOK');
        } else if (i == 2) {
          platformList.add('YOUTUBE');
        }
      }
    }
    List<String> regionList = [];
    for (int i = 0; i < regionController.selectedRegions.length; i++) {
      regionList
          .add(regionController.getEnum(regionController.selectedRegions[i]));
    }

    campaign = Campaign(
      registerId: userController.memberId,
      adCategory: category,
      title: campaignTitle,
      numberOfRecruiter: recruitCount,
      isPriceChangeable: false,
      isDeliveryRequired: deliveryPositive,
      price: int.parse(payController.pay),
      sellingLink: link,
      details: offeringItems,
      offeringDetails: itemDetail,
      adPlatformList: platformList,
      minClouterAge: ageController.ageRanges.start.toInt(),
      maxClouterAge: ageController.ageRanges.end.toInt(),
      minFollower: int.parse(followerController.minimumFollowers),
      regionList: regionList,
    );
  }

  setCategory(input) {
    category = input;
    update();
  }

  setCampaignTitle(input) {
    campaignTitle = input;
    update();
  }

  setRecruitCount(input) {
    recruitCount = input;
    update();
  }

  setOfferingItems(input) {
    offeringItems = input;
    update();
  }

  setItemDetail(input) {
    itemDetail = input;
    update();
  }

  setSignature(input) {
    signature = input;

    update();
  }

  setPayPositive(input) {
    payPositive = input;
    update();
  }

  setDeliveryPositive(input) {
    deliveryPositive = input;
    update();
  }

  setLink(input) {
    link = input;
    update();
  }

  setBlank(input){
    isBlank = input;
    update();
  }

  printAll() {
    print(category);
    print(campaignTitle);
    print(recruitCount);
    print(offeringItems);
    print(itemDetail);
    print(signature);
    print(ageController.ageRanges.start);
    print(ageController.ageRanges.end);
    print(payController.pay);
    print(payController.payString);
    print(platformController.platforms);
    print(followerController.minimumFollowers);
    print(regionController.selectedRegions);
  }
}
