import 'dart:ui';

import 'package:clout/hooks/apis/authorized_api.dart';
import 'package:clout/hooks/contract_maker.dart';
import 'package:clout/providers/contract_controller.dart';
import 'package:clout/screens/campaign_register/widgets/utils.dart';
import 'package:clout/screens/contract_list/contract_list.dart';
import 'package:clout/screens/contract_list/widgets/contract_button.dart';
import 'package:clout/screens/register_or_modify/widgets/join_input.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:clout/widgets/signature.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:clout/style.dart' as style;
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:http_parser/http_parser.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class ConfirmButton extends StatefulWidget {
  ConfirmButton({super.key, required this.title, required this.contractId});

  final title;
  final contractId;

  @override
  State<ConfirmButton> createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  final contractController = Get.put(ContractController());

  final GlobalKey stackGlobalKey = GlobalKey();

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  Future<void> handleSignature() async {
    print("START CAPTURE");
    final renderObject = stackGlobalKey.currentContext!.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      ui.Image image = await boundary.toImage(pixelRatio: 5.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        contractController.setSignature(byteData.buffer.asUint8List());
        // await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
        Utils.toast('서명이 안전하게 처리되었습니다.');
      }
    } else {
      print('여기로 왔는데?');
    }
  }

  confirmContract() async {
    AuthorizedApi api = AuthorizedApi();
    await handleSignature();
    await contractController.loadContractData(widget.contractId);
    await contractController.setResidentRegistrationNumber();

    ContractMaker contractMaker = ContractMaker();
    await contractMaker.generateContract(0);

    var response1 = await api.patchRequest(
      '/contract-service/v1/contracts/${widget.contractId}',
      {
        'residentRegistrationNumber': contractController
            .contractInfo!.clouterInfo!.residentRegistrationNumber
      },
    );
    var response2 = await api.dioPatchRequestSingleFile(
      '/contract-service/v1/contracts/${widget.contractId}/complete',
      contractController.contractFile,
    );

    // 계약서 관련 정보 담고 있는 컨트롤러 날리기
    Get.delete<ContractController>();
    print(response1);
    print(response2);

    Get.back();
    Get.off(() => ContractList());
    showSnackBar();
  }

  showSnackBar() {
    Get.snackbar(
      '',
      '',
      // snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 4),
      titleText: Text(
        '🥳 계약 체결 완료',
        style: style.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '광고 계약을 진심으로 축하드려요',
            style: style.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            '기세를 이어가 볼까요? 🙌',
            style: style.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      borderWidth: 5,
      borderColor: style.colors['main1'],
      margin: EdgeInsets.only(
        top: 15,
        left: 20,
        right: 20,
      ),
    );
  }

  showConfirmDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      builder: (BuildContext context) => GetBuilder<ContractController>(
        builder: (controller) => Container(
          height: 600,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '계약서 필수정보 입력',
                  style: style.textTheme.titleSmall?.copyWith(
                      color: style.colors['text'], fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '주민등록번호',
                style: style.textTheme.headlineMedium?.copyWith(
                    color: style.colors['text'], fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 40,
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 6,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      onChanged: (value) => controller.setFrontNumber(value),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        floatingLabelStyle:
                            TextStyle(color: style.colors['main1']),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 2,
                            color: style.colors['main1']!,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text('ㅡ'),
                  SizedBox(
                    height: 40,
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 7,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      onChanged: (value) => controller.setBackNumber(value),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        floatingLabelStyle:
                            TextStyle(color: style.colors['main1']),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            width: 2,
                            color: style.colors['main1']!,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Signature(
                globalKey: stackGlobalKey,
                signatureKey: signatureGlobalKey,
                setBlank: controller.setBlank,
                signatureSubject: '( 수임인 서명 )',
              ),
              SizedBox(height: 40),
              SizedBox(
                  width: double.infinity,
                  child: BigButton(title: '계약 확정하기', function: confirmContract))
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(120, 40),
        backgroundColor: style.colors['main1'],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      onPressed: showConfirmDialog,
      child: Text(widget.title),
    );
  }
}
