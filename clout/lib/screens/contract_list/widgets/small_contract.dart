import 'package:clout/providers/user_controllers/user_controller.dart';
import 'package:clout/screens/campaign_register/widgets/data_title.dart';
import 'package:clout/screens/contract_list/widgets/confirm_button.dart';
import 'package:clout/screens/contract_list/widgets/contract_button.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

class SmallContract extends StatefulWidget {
  final int contractId;
  final String name;
  final String pay;
  final bool progress;

  const SmallContract({
    super.key,
    required this.name,
    required this.contractId,
    required this.pay,
    required this.progress,
  });

  @override
  State<SmallContract> createState() => _SmallContractState();
}

class _SmallContractState extends State<SmallContract> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      margin: EdgeInsets.only(top: 10),
      // height: 100,
      decoration: BoxDecoration(
        color: style.colors['white'],
        borderRadius: BorderRadius.circular(5),
        boxShadow: style.shadows['shadow'],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.progress == false
                    ? Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: style.colors['main3'],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          '계약 대기중',
                          style: style.textTheme.bodySmall,
                        ))
                    : Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: style.colors['main2'],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          '계약 확정',
                          style: style.textTheme.bodySmall
                              ?.copyWith(color: Colors.white),
                        )),
                SizedBox(height: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DataTitle(text: widget.name),
                    SizedBox(height: 7),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.card_giftcard_outlined,
                            size: 17, color: style.colors['main1']),
                        Text(' 제공내역 ',
                            style: TextStyle(
                              fontSize: 13,
                            )),
                        Text(
                          '${widget.pay} 포인트',
                          style: TextStyle(
                            fontSize: 13,
                            color: style.colors['main1'],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                !widget.progress
                    ? ConfirmButton(
                        title: '계약 확정하기', contractId: widget.contractId)
                    : SizedBox(),
                ContractButton(
                  title: '계약서 보기',
                  contractId: widget.contractId,
                  buttonHeight: widget.progress ? 80 : 40,
                  progress: widget.progress,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
