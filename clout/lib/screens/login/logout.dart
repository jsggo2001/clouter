import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/hooks/apis/logout_api.dart';
import 'package:clout/hooks/apis/normal_api.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:get/get.dart';

void logout() async {
  final userController = Get.find<UserController>();
  // 0. api에 전송
  final AuthorizedApi api = AuthorizedApi();
  api.postRequest('/member-service/v1/members/logout', '');
  // 백에선 auth만 넘기면 자동으로 삭제해 준다네요

  // 1. 로그인 정보 삭제
  // var userLogout = {
  //       'login_success': false,
  //       'authorization': '',
  //       'refresh_token': '',
  //       'clout_or_adv': 0,
  // };
  // userController.setUserLogin(null);
  userController.setGuest();
  userController.setMemberId(-1);
  userController.setUserLogin(null);
  userController.setAccessToken(null);
  userController.setRefreshToken(null);
  
  // 3. 홈으로 이동
  Get.offAllNamed('/');
}
