import 'package:clout/providers/scroll_controllers/infinite_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CampaignInfiniteScrollBody extends StatelessWidget {
  const CampaignInfiniteScrollBody({super.key, required this.controllerTag});

  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InfiniteScrollController>(
      tag: controllerTag,
      builder: (controller) => MasonryGridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (_, index) {
          final campaign1 = controller.data[index];
          return campaign1;
        },
        itemCount: controller.data.length,
      ),
    );
  }
}
