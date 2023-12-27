import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AgeController extends GetxController {
  SfRangeValues ageRanges = SfRangeValues(0, 100);

  void setAgeRanges(input) {
    ageRanges = input;
    update();
    print(ageRanges);
  }
}
