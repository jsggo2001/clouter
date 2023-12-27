import 'package:get/get.dart';

class FourDigitsInputController extends GetxController {
  var correctPin;
  var inputPin;
  var phoneVerified = false;

  setCorrectPin(input) {
    correctPin = input;
    update();
  }

  setInputPin(input) {
    inputPin = input;
    update();
  }

  setPhoneVerified(input){
    phoneVerified = input;
    update();
  }



}
