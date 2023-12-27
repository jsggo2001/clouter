import 'package:get/get.dart';
import 'package:clout/type.dart';

class UserController extends GetxController {
  int memberType = 0;
  int memberId = -1; // db에서 관리하는 유저의 primaryKey
  var userId; // 유저가 로그인할때 사용하는 id
  var password;
  var accessToken;
  var refreshToken;

  var userInfo;
  var userLogin;

  void setAdvertiser() {
    memberType = 1;
    update();
  }

  void setClouter() {
    memberType = -1;
    update();
  }

  void setGuest() {
    memberType = 0;
    update();
  }

  setMemberId(input) {
    memberId = input;
    update();
  }

  setUserId(input) {
    userId = input;
    update();
  }

  // setPassword(input) {
  //   password = input;
  //   update();
  // }

  // setUserInfo() {
  //   userInfo = LoginInfo(
  //       // user,
  //       userId,
  //       password);
  //   print('유저인포 업데이트');
  //   update();
  // }

  setUserLogin(input) {
    userLogin = input;
    update();
  }

  setAccessToken(input) {
    accessToken = input;
    update();
  }

  setRefreshToken(input) {
    refreshToken = input;
    update();
  }
}
