import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/providers/fee_controller.dart';
import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CampaginApplyController extends GetxController {
  String? oneSay;
  var agreed = false;
  int hopeAdFee = 0;
  var advertisementId = Get.arguments;

  final userController = Get.find<UserController>();

  setOneSay(input) {
    oneSay = input;
    update();
  }

  setAgreed(input) {
    agreed = input;
    update();
  }

  final feeController = Get.put(FeeController(), tag: 'campaignApply');

  applyCampaign() async {
    final AuthorizedApi api = AuthorizedApi();

    var requestBody = {
      "advertisementId": advertisementId,
      "clouterId": userController.memberId,
      "applyMessage": oneSay,
      "hopeAdFee": feeController.pay,
    };

    var response =
        await api.postRequest('/advertisement-service/v1/applies', requestBody);
    print(requestBody);
    print(response);

    if (response['statusCode'] == 201) {
      print('캠페인 지원이 완료되었습니다. ✨');
    } else {
      print('캠페인 지원에 실패하였습니다.. 다시 한 번 시도해주세요!😥');
      print('${response['body']}');
    }
  }
}
