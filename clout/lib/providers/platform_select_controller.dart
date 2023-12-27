import 'package:get/get.dart';

class PlatformSelectController extends GetxController {
  var platforms = [false, false, false];

  var id = ['', '', ''];
  var link = ['', '', ''];
  var followerCount = ['0', '0', '0'];
  var followerCountString = ['0 명', '0 명', '0 명'];

  numbering(value, division) {
    return (value / division).floor();
  }

  followerConverter(input) {
    if (input.length > 1) {
      int number = int.parse(input);
      var numbers = [
        numbering(number, 100000000),
        numbering(number % 100000000, 10000),
        numbering(number % 10000, 1000),
        numbering(number % 1000, 1)
      ];
      var result = '';
      var unit = ["억", '만', '천', ''];
      for (var i = 0; i < numbers.length; i++) {
        if (numbers[i] >= 1) {
          result += '${numbers[i]}${unit[i]} ';
        }
      }
      return result;
    } else {
      return input;
    }
  }

  void setSelected(int index, bool multiAllowed) {
    var alreadyTrue;
    for (int i = 0; i < 3; i++) {
      if (platforms[i]) alreadyTrue = i;
    }
    if (!multiAllowed) {
      platforms = [false, false, false];
      if (alreadyTrue != null) {
        if (index != alreadyTrue) platforms[index] = !platforms[index];
      } else {
        if (index != alreadyTrue) platforms[index] = !platforms[index];
      }
    } else {
      platforms[index] = !platforms[index];
    }
    update();
    print(platforms);
  }

  setId(index, input) {
    id[index] = input;
    update();
  }

  setLink(index, input) {
    link[index] = input;
    update();
  }

  setFollowerCount(index, input) {
    followerCount[index] = input;
    if (input != null) {
      setFollowerCountString(index, followerConverter(input));
    }
    if (input.length == 0) {
      followerCount[index] = '0';
      setFollowerCountString(index, followerConverter('0'));
    }
    update();
  }

  setFollowerCountString(index, input) {
    followerCountString[index] = '$input 명';
    update();
  }
}
