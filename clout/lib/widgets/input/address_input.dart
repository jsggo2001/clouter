import 'package:clout/providers/address_controller.dart';
import 'package:clout/screens/register_or_modify/widgets/join_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:clout/widgets/address/library_daum_post_webview.dart';
import 'package:clout/style.dart' as style;

class AddressInput extends StatelessWidget {
  AddressInput({super.key, required this.controllerTag});
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      tag: controllerTag,
      builder: (controller) => Column(
        children: [
          OutlinedButton(
            onPressed: () async {
              final value = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LibraryDaumPostcodeScreen(),
                ),
              );
              if (value != null) {
                final DataModel dataModel = value;
                controller.setZipCode(dataModel.zonecode);
                controller.setDaumAddress(dataModel.address);
              }
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              side: BorderSide(color: Colors.grey),
            ),
            child: SizedBox(
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home,
                    color: style.colors['main1'],
                  ),
                  SizedBox(width: 10),
                  Text(
                    controller.daumAddress,
                    style: style.textTheme.bodyLarge?.copyWith(
                      color: controller.daumAddress == '주소 검색'
                          ? Colors.grey[700]
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          JoinInput(
            keyboardType: TextInputType.text,
            maxLength: 30,
            title: '상세 주소 입력',
            label: '상세 주소',
            setState: controller.setDetailAddress,
            initialValue: controller.detailAddress,
            enabled: true,
          ),
        ],
      ),
    );
  }
}
