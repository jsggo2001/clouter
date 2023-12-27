import 'package:clout/providers/age_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:clout/style.dart' as style;

class AgeSlider extends StatelessWidget {
  AgeSlider({super.key, required this.controllerTag});
  final controllerTag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AgeController>(
      tag: controllerTag,
      builder: (controller) {
        return SfRangeSliderTheme(
          data: SfRangeSliderThemeData(
            tooltipBackgroundColor: style.colors['main2'],
            thumbColor: style.colors['white'],
            thumbStrokeWidth: 1,
            thumbStrokeColor: style.colors['main1'],
            activeTrackColor: style.colors['main1'],
            inactiveTrackColor: style.colors['category'],
            activeLabelStyle: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            inactiveLabelStyle: TextStyle(color: Colors.black, fontSize: 10),
          ),
          child: SfRangeSlider(
            enableTooltip: true,
            min: 0.0,
            max: 100.0,
            values: controller.ageRanges,
            showTicks: true,
            showLabels: true,
            stepSize: 1,
            interval: 20,
            numberFormat: NumberFormat("###세"),
            onChanged: (SfRangeValues values) {
              controller.setAgeRanges(values);
            },
          ),
        );
      },
    );
  }
}
