import 'package:clout/providers/age_controller.dart';
import 'package:clout/providers/fee_controller.dart';
import 'package:clout/providers/follower_controller.dart';
import 'package:clout/providers/platform_select_controller.dart';
import 'package:clout/providers/region_controller.dart';
import 'package:get/get.dart';

class HeaderController extends GetxController {
  int header = 0;
  var headerTitle = '채널명/메뉴명';

  void setHeader(headerType) {
    header = headerType;
    update();
  }

  void setHeaderTitle(title) {
    headerTitle = title;
    update();
  }

  void resetHeaderTitle() {
    headerTitle = "";
    // 여긴 일단 update() 안해놓음 비동기로 바로 반영될까봐
  }

  // final platformController = Get.put(PlatformSelectController());
  // final feeController = Get.put(FeeController());
  // final followerContoller = Get.put(FollowerContoller());
  // final ageController = Get.put(AgeController());
  // final regionController = Get.put(RegionController());

  // void resetSearchDetail() {
  //   Get.delete<PlatformSelectController>(force: true);
  //   Get.delete<FeeController>(force: true);
  //   Get.delete<FollowerContoller>(force: true);
  //   Get.delete<AgeController>(force: true);
  //   Get.delete<RegionController>(force: true);
  // }
}
