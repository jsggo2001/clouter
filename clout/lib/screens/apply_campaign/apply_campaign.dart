import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:clout/style.dart' as style;

// controllers
import 'package:clout/providers/campaign_apply_controller.dart';
import 'package:clout/providers/fee_controller.dart';

// widgets
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/common/custom_snackbar.dart';
import 'package:clout/widgets/pay_dialog.dart';
import 'package:clout/widgets/header/header.dart';
import 'package:clout/widgets/input/input_elements/widgets/text_input.dart';

// utilties
import 'package:clout/utilities/bouncing_listview.dart';

String agreement =
    '1. 개인정보의 수집항목 및 수집방법 \n클라우트에서는 기본적인 회원 서비스 제공을 위한 필수정보로 실명인증정보와 가입정보로 구분하여 다음의 정보를 수집하고 있습니다. 필수정보를 입력해주셔야 회원 서비스 이용이 가능합니다. \n  가. 수집하는 개인정보의 항목\n   * 수집하는 필수항목\n      - 실명인증정보 : 이름, 휴대전화번호, 본인 인증 또는 I-PIN(개인식별번호), GPKI\n      - 가입정보 : 아이디, 비밀번호, 성명, 이메일, 전화번호, 휴대전화번호, 기관명\n     * 선택항목\n      - 주소, 기관의 부서명\n \n \n \n   [컴퓨터에 의해 자동으로 수집되는 정보]\n    인터넷 서비스 이용과정에서 아래 개인정보 항목이 자동으로 생성되어 수집될 수 있습니다.\n \n     - IP주소, 서비스 이용기록, 방문기록 등\n \n \n   나. 개인정보 수집방법\n       홈페이지 회원가입을 통한 수집\n \n \n 2. 개인정보의 수집/이용 목적 및 보유/이용 기간\n \n 클라우트에서는 정보주체의 회원 가입일로부터 서비스를 제공하는 기간 동안에 한하여 클라우트 서비스를 이용하기 위한 최소한의 개인정보를 보유 및 이용 하게 됩니다. 회원가입 등을 통해 개인정보의 수집·이용, 제공 등에 대해 동의하신 내용은 언제든지 철회하실 수 있습니다. 회원 탈퇴를 요청하거나 수집/이용목적을 달성하거나 보유/이용기간이 종료한 경우, 사업 폐지 등의 사유발생시 개인 정보를 지체 없이 파기합니다.\n \n   * 실명인증정보\n     - 개인정보 수집항목 : 이름, 휴대폰 본인 인증 또는 I-PIN(개인식별번호), GPKI\n     - 개인정보의 수집·이용목적   : 홈페이지 이용에 따른 본인 식별/인증절차에 이용\n     - 개인정보의 보유 및 이용기간 : I-PIN / GPKI는 별도로 저장하지 않으며 실명인증용으로만 이용\n  \n   * 가입정보\n     - 개인정보 수집항목 : 아이디, 비밀번호, 성명, 이메일, 전화번호, 휴대전환번호, 기관명\n \n \n \n - 개인정보의 수집·이용목적 : 홈페이지 서비스 이용 및 회원관리, 불량회원의 부정 이용방지, 민원신청 및 처리 등\n     - 개인정보의 보유 및 이용기간 : 2년 또는 회원탈퇴시\n \n 정보주체는 개인정보의 수집·이용목적에 대한 동의를 거부할 수 있으며, 동의 거부시 클라우트에 회원가입이 되지 않으며, 클라우트에서 제공하는 서비스를 이용할 수 없습니다.\n \n 3. 수집한 개인정보 제3자 제공\n 클라우트에서는 정보주체의 동의, 법률의 특별한 규정 등 개인정보 보호법 제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.\n 4. 개인정보 처리업무 안내\n 클라우트에서는 개인정보의 취급위탁은 하지 않고 있으며, 원활한 서비스 제공을 위해 아래의 기관을 통한 실명인증 및 공공 I-PIN, GPKI 인증을 하고 있습니다.\n \n   * 수탁업체\n     - 행정자치부\n       · 위탁업무 내용 : 공공 I-PIN, GPKI 인증\n       · 개인정보 보유 및 이용 기간 : 행정자치부에서는 이미 보유하고 있는 개인정보이기 때문에 별도로 저장하지 않음\n';

class ApplyCampaign extends StatefulWidget {
  ApplyCampaign({super.key});

  @override
  State<ApplyCampaign> createState() => _ApplyCampaignState();
}

class _ApplyCampaignState extends State<ApplyCampaign> {
  final ScrollController _scrollController = ScrollController();

  final applyController =
      Get.put(CampaginApplyController(), tag: 'campaignApply');
  final feeController = Get.find<FeeController>(tag: 'campaignApply');

  doApply() {
    if (applyController.agreed) {
      applyController.applyCampaign().then((_) {
        CustomSnackbar(
                title: '🎉 캠페인 지원 완료!',
                message1: '캠페인 지원을 성공적으로 마쳤어요. 😊',
                message2: '클라우터님께서 채택되시길 바라요! 👍')
            .show();
      }).catchError((error) {});
      Get.back();
    } else {
      // showCustomToast();
      Fluttertoast.showToast(msg: '개인정보 수집 및 이용에 동의해주세요');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaginApplyController>(
      tag: 'campaignApply',
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(
            header: 3,
            headerTitle: '못골정미소 백미 5kg',
          ),
        ),
        body: Container(
          // color: Colors.blue,
          width: double.infinity,
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: BouncingListview(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '체험단 신청',
                    style: style.textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 20),
                  Text(
                    '신청 한 마디',
                    style: style.textTheme.headlineSmall,
                  ),
                  Text('광고주가 참고할 만한 한 마디를 남겨 주세요!'),
                  SizedBox(height: 10),
                  TextInput(
                    setData: controller.setOneSay,
                    placeholder: '클라우터님을 자유롭게 어필해보세요.',
                    maxLength: 300,
                    maxValue: -1,
                    minLines: 7,
                    maxLines: 7,
                  ),
                  SizedBox(height: 10),
                  /////// 광고비가 있다면(추후 협의인 광고라면.)
                  Text(
                    '희망 광고비',
                    style: style.textTheme.headlineSmall,
                  ),
                  PayDialog(
                    title: '희망 광고비',
                    hintText: '희망 광고비',
                    controllerTag: 'campaignApply',
                  ),
                  SizedBox(height: 20),
                  Text(
                    '개인정보 수집/이용 동의',
                    style: style.textTheme.headlineSmall,
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 200,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.grey[200],
                    ),
                    child: Scrollbar(
                      controller: _scrollController,
                      thumbVisibility: true,
                      radius: Radius.circular(50),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: _scrollController,
                        scrollDirection: Axis.vertical,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            agreement,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: style.colors['main1'],
                        value: controller.agreed,
                        onChanged: (value) => controller.setAgreed(value),
                      ),
                      Text(
                        '개인정보 수집 및 이용에 동의합니다.',
                        style:
                            style.textTheme.bodyMedium?.copyWith(height: 1.2),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: BigButton(
                        title: '지원하기',
                        function: doApply,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
