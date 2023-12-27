import 'package:clout/providers/scroll_controllers/clouter_infinite_scroll_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ClouterInfiniteScrollBody extends StatelessWidget {
  const ClouterInfiniteScrollBody({super.key, required this.controllerTag});

  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClouterInfiniteScrollController>(
      tag: controllerTag,
      builder: (controller) => MasonryGridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (_, index) {
          final clouter1 = controller.data[index];
          return clouter1;
        },
        itemCount: controller.data.length,
      ),
    );
  }
}
