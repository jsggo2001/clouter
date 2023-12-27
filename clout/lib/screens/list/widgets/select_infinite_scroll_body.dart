import 'package:clout/providers/scroll_controllers/select_infinite_scroll_controller.dart';
import 'package:clout/type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SelectInfiniteScrollBody extends StatelessWidget {
  const SelectInfiniteScrollBody({super.key, required this.controller});

  final SelectInfiniteScrollController controller;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemBuilder: (_, index) {
        final selectClouter = controller.data[index];
        return selectClouter;
      },
      itemCount: controller.data.length,
    );
  }
}
