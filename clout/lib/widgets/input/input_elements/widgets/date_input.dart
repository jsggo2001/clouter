import 'package:clout/providers/date_input_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:clout/style.dart' as style;
import 'package:get/get.dart';

class DateInput extends StatelessWidget {
  DateInput({
    super.key,
    required this.controllerTag,
  });
  final controllerTag;

  showDatePickerDialog() {
    Get.defaultDialog(
      title: '생년월일',
      titlePadding: EdgeInsets.fromLTRB(0, 30, 0, 20),
      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 30),
      actions: [
        SizedBox(
          width: 200,
          child: ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: style.colors['main1'],
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('확인'),
          ),
        ),
      ],
      content: GetBuilder<DateInputController>(
        tag: controllerTag,
        builder: (controller) => SizedBox(
          height: 250,
          width: 300,
          child: SfDateRangePicker(
            onSelectionChanged: (value) => controller.setSelectedDate(value),
            selectionMode: DateRangePickerSelectionMode.single,
            todayHighlightColor: style.colors['main1'],
            headerStyle: DateRangePickerHeaderStyle(
                textStyle: style.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.w500)),
            view: DateRangePickerView.decade,
            selectionColor: style.colors['main1'],
            initialSelectedDate: controller.selectedDate,
            showNavigationArrow: true,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateInputController>(
      tag: controllerTag,
      builder: (controller) => OutlinedButton(
        onPressed: showDatePickerDialog,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: BorderSide(color: Colors.grey),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: style.colors['main1'],
              ),
              SizedBox(width: 10),
              Text(
                DateFormat('yyyy.MM.dd').format(controller.selectedDate) !=
                        DateFormat('yyyy.MM.dd').format(DateTime.now())
                    ? DateFormat('yyyy.MM.dd').format(controller.selectedDate)
                    : '생년월일',
                style:
                    DateFormat('yyyy.MM.dd').format(controller.selectedDate) !=
                            DateFormat('yyyy.MM.dd').format(DateTime.now())
                        ? style.textTheme.headlineSmall
                            ?.copyWith(color: style.colors['text'], height: 1.3)
                        : style.textTheme.headlineSmall
                            ?.copyWith(color: Colors.grey[700], height: 1.2),
                // style: ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
