import 'package:clout/providers/fee_controller.dart';
import 'package:clout/hooks/numeric_range_formatter.dart';
import 'package:clout/widgets/buttons/big_button.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PayDialog extends StatelessWidget {
  PayDialog(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controllerTag});
  final title;
  final hintText;
  final controllerTag;

  openPayDialog() {
    Get.defaultDialog(
      title: title,
      titlePadding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      content: GetBuilder<FeeController>(
        tag: controllerTag,
        builder: (controller) => SizedBox(
          height: 75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextFormField(
                inputFormatters: [
                  NumericRangeFormatter(min: 0, max: 1000000000),
                  FilteringTextInputFormatter.digitsOnly
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: EdgeInsets.only(left: 15, right: 15),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: style.colors['main1']!, width: 2))),
                initialValue: controller.pay == '0' ? '' : controller.pay,
                onChanged: (newVal) {
                  controller.setPay(newVal);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(controller.payString),
                ],
              )
            ],
          ),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: BigButton(
            function: () => Get.back(),
            title: '확인',
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeeController>(
      tag: controllerTag,
      builder: (controller) => SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => openPayDialog(),
              style: ButtonStyle(
                  padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  minimumSize: MaterialStatePropertyAll(Size(200, 50)),
                  alignment: Alignment.centerRight),
              child: Text(
                controller.payString,
                style: style.textTheme.titleMedium?.copyWith(
                  color: style.colors['main1'],
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
