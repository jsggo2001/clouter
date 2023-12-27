import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

// widgets
import 'package:clout/widgets/header/header.dart';
import 'package:clout/screens/point/widgets/bank_dropdown.dart';
import 'package:clout/screens/point/widgets/main_text.dart';
import 'package:clout/utilities/bouncing_listview.dart';
import 'package:clout/widgets/buttons/big_button.dart';

class AddFirst extends StatefulWidget {
  const AddFirst({super.key});

  @override
  State<AddFirst> createState() => _AddFirstState();
}

class _AddFirstState extends State<AddFirst> {
  var bank;
  TextEditingController _accountController = TextEditingController();

  setBank(input) {
    setState(() {
      bank = input;
    });
    print(bank);
  }

  Future goSecond(BuildContext context, String bank, String account) async {
    final arguments = {
      'bank': bank,
      'account': _accountController.text,
    };
    print(arguments);
    Get.toNamed('/addsecond', arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Header(header: 4, headerTitle: '')),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: BouncingListview(
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                MainText(textTitle: '충전할 계좌를'),
                MainText(textTitle: '입력해주세요'),
                SizedBox(height: 20),
                // BankDropdown(bank: category, setBank: setCategory),
                BankDropdown(
                  bank: bank,
                  setBank: setBank,
                ),
                TextFormField(
                  controller: _accountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(labelText: '계좌번호 (- 없이 입력해주세요)'),
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: BigButton(
            title: '다음',
            function: () => {
              if (bank == null || _accountController.text == null)
                {Fluttertoast.showToast(msg: "계좌 정보를 입력해주세요.")}
              else
                {goSecond(context, bank, _accountController.text)}
            },
          ),
        ),
      ),
    );
  }
}
