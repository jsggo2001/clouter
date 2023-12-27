import 'package:clout/screens/campaign_register/widgets/data_title.dart';
import 'package:clout/widgets/number_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:clout/style.dart' as style;

class RecruitInput extends StatelessWidget {
  RecruitInput({super.key, this.recruitCount, this.setRecruitCount});
  final recruitCount;
  final setRecruitCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: ((context) {
                      return NumberPickerDialog(
                        value: recruitCount,
                        minValue: 1,
                        maxValue: 100,
                        setData: setRecruitCount,
                      );
                    })),
                child: Text(
                  '${recruitCount.toString()} 명',
                  style: style.textTheme.titleMedium?.copyWith(
                      color: style.colors['main1'],
                      fontWeight: FontWeight.bold,
                      height: 1.1),
                )),
          ],
        ));
  }
}
