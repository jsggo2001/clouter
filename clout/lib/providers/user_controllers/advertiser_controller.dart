import 'package:get/get.dart';

class AdvertiserController extends GetxController {
  var controllerTag;

  setControllerTag(input) {
    controllerTag = input;
    update();
  }
}
