import 'package:get/get.dart';

class DateInputController extends GetxController {
  DateTime selectedDate = DateTime.now();

  int? age;

  setSelectedDate(input) {
    selectedDate = input.value;
    setAge(DateTime.now().year - input.value.year);
    print(input);
    update();
  }

  setSelectedDateDirectly(input) {
    selectedDate = input;
    update();
  }

  setAge(input) {
    age = input;
    print(input);
    update();
  }
}
