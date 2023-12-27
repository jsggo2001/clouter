import 'package:get/get.dart';

class ClouterController extends GetxController {
  var controllerTag;

  setControllerTag(input) {
    controllerTag = input;
    update();
  }
}
