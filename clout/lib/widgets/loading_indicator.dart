import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clout/style.dart' as style;
import 'package:loading_indicator/loading_indicator.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingIndicator(
      // indicatorType: Indicator.ballRotateChase,
      indicatorType: Indicator.circleStrokeSpin, 
      colors: [
        style.colors['main1-4']!,
        style.colors['main1-3']!,
        style.colors['main1-2']!,
        style.colors['main1-1']!,
        style.colors['main1']!,
      ],
    ));
  }
}
