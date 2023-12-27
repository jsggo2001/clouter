import 'package:get/get.dart';

class FollowerController extends GetxController {
  var minimumFollowers = '0';
  var minimumFollowersString = '0 명';

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

  void setMinimumFollowers(input) {
    minimumFollowers = input;
    if (minimumFollowers != null) {
      setMinimumFollowersString(followerConverter(input));
    }
    if (input.length == 0) {
      minimumFollowers == '0';
      setMinimumFollowersString(followerConverter('0'));
    }
    update();
  }

  void setMinimumFollowersString(input) {
    minimumFollowersString = '$input 명';
    update();
  }
}
