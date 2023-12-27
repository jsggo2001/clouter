import 'package:clout/providers/age_controller.dart';
import 'package:clout/providers/fee_controller.dart';
import 'package:clout/providers/follower_controller.dart';
import 'package:clout/providers/platform_select_controller.dart';
import 'package:clout/providers/region_controller.dart';
import 'package:get/get.dart';

class SearchDetailController extends GetxController {
  final platformSelectController = Get.put(
    PlatformSelectController(),
    tag: 'searchDetail',
  );
  final ageController = Get.put(
    AgeController(),
    tag: 'searchDetail',
  );
  final followerController = Get.put(
    FollowerController(),
    tag: 'searchDetail',
  );
  final payController = Get.put(
    FeeController(),
    tag: 'searchDetail',
  );
  final regionController = Get.put(
    RegionController(),
    tag: 'searchDetail',
  );

  String getSearchUrl() {
    String returnVal = '';
    for (int i = 0; i < 3; i++) {
      if (platformSelectController.platforms[i]) {
        returnVal = '${returnVal}&platform=';
        if (i == 0) {
          returnVal = '${returnVal}INSTAGRAM';
        } else if (i == 1) {
          returnVal = '${returnVal}TIKTOK';
        } else {
          returnVal = '${returnVal}YOUTUBE';
        }
      }
    }

    for (int i = 0; i < regionController.selectedRegions.length; i++) {
      returnVal =
          '$returnVal&region=${regionController.getEnum(regionController.selectedRegions[i])}';
    }

    return "$returnVal"
        "&minAge=${ageController.ageRanges.start}"
        "&maxAge=${ageController.ageRanges.end}"
        "&minFollower=${followerController.minimumFollowers}"
        "&minPrice=${payController.minFee ?? 0}"
        "&maxPrice=${payController.maxFee ?? 1000000000}";
  }
}
