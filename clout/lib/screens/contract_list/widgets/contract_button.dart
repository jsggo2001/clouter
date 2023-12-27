// 계약서
import 'dart:typed_data';
import 'package:clout/hooks/contract_maker.dart';
import 'package:clout/providers/contract_controller.dart';
import 'package:clout/screens/contract_list/utilities/save_file_mobile.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class ContractButton extends StatelessWidget {
  ContractButton(
      {super.key,
      required this.title,
      required this.contractId,
      required this.progress,
      this.buttonHeight}) {
    buttonHeight ??= 40;
  }

  final title;
  final contractId;
  final progress;
  double? buttonHeight;

  final contractController = Get.put(ContractController());

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(120, buttonHeight!),
        backgroundColor: style.colors['main1'],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      onPressed: () async {
        if (progress) {
          await contractController.loadContractFile(contractId);
        } else {
          await contractController.loadContractData(contractId);
          ContractMaker contractMaker = ContractMaker();
          contractMaker.generateContract(1);
        }
      },
      child: Text(title),
    );
  }
}
