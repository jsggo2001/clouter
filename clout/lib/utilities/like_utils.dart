import 'package:clout/hooks/apis/authorized_api.dart';

Future<void> sendLikeStatus(
    int memberId, int? targetId, bool isLiked, bool isClouter) async {
  // targetId가 null인 경우 함수를 바로 종료합니다.
  if (targetId == null) {
    print('targetId가 null입니다.');
    return;
  }
  final AuthorizedApi authorizedApi = AuthorizedApi();

  var requestBody = {
    "memberId": memberId,
    "targetId": targetId,
  };

  // isLiked = !isLiked;

  // 북마크 생성
  if (isLiked && !isClouter) {
    var response = await authorizedApi.postRequest(
        '/member-service/v1/bookmarks/ad', requestBody);

    if (response['statusCode'] == 200) {
      print('캠페인 Bookmark 성공~~🎉');
    } else {
      print('캠페인 Bookmark 실패 ❌');
    }
  } else if (isLiked && isClouter) {
    var response = await authorizedApi.postRequest(
        '/member-service/v1/bookmarks/clouter', requestBody);

    if (response['statusCode'] == 200) {
      print('클라우터 Bookmark 성공~~🎉');
    } else {
      print('클라우터 Bookmark 실패 ❌');
    }
  } else {
    var response = await authorizedApi.deleteRequest(
        '/member-service/v1/bookmarks/delete', requestBody);

    if (response['statusCode'] == 200) {
      print('Bookmark delete 성공~~🎉');
    } else {
      print('Bookmark delete 실패 ❌');
    }
  }
}
