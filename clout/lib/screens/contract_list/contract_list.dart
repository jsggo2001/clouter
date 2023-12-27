import 'package:clout/widgets/loading_indicator.dart';
import 'package:clout/widgets/refreshable_container.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

// widgets
import 'package:clout/widgets/common/choicechip.dart';
import 'package:clout/widgets/header/header.dart';

// controllers
import 'package:clout/providers/scroll_controllers/contract_infinite_scroll_controller.dart';

class ContractList extends GetView<ContractInfiniteScrollController> {
  ContractList({super.key});

  var contractId = Get.arguments;

  final contractController = Get.put(ContractInfiniteScrollController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: style.colors['white'],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Header(
          header: 4,
          headerTitle: '내 계약서 목록',
        ),
      ),
      body: GetBuilder<ContractInfiniteScrollController>(
        builder: (controller) => RefreshableContainer(
          controller: controller.scrollController.value,
          child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                children: [
                  ActionChoiceExample(
                    labels: ['전체 내역', '서명 대기', '진행중', '계약 만료'],
                    chipCount: 4,
                    onChipSelected: (label) {},
                  ),
                  !controller.isLoading
                      ? controller.data.isEmpty
                          ? Column(
                              children: [
                                SizedBox(height: 50),
                                Image.asset(
                                  'assets/images/empty_campaign.png',
                                  width: 70,
                                  fit: BoxFit.fitWidth,
                                ),
                                SizedBox(height: 20),
                                Text(
                                  '대기 중이거나 확정된 계약서가 없어요 😢',
                                  style: style.textTheme.headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          : Column(
                              children: [
                                ...controller.data,
                                controller.hasMore && controller.dataLoading
                                    ? Column(
                                        children: [
                                          SizedBox(height: 50),
                                          SizedBox(
                                              height: 70,
                                              child: Center(
                                                  child: LoadingWidget())),
                                        ],
                                      )
                                    : Container()
                              ],
                            )
                      : Column(
                          children: [
                            SizedBox(height: screenHeight / 4),
                            SizedBox(
                                height: 70,
                                child: Center(child: LoadingWidget())),
                            SizedBox(height: 20),
                            Text(
                              '계약서 목록을 불러오는 중입니다.\n잠시만 기다려 주세요.',
                              style: style.textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                  SizedBox(height: 30),
                ],
              )),
        ),
      ),
    );
  }
}
