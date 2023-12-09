import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateTimeController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  String get formattedDate => formatDate(
      selectedDate.value, [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
}

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({
    Key? key,
    required this.controller,
    required this.labelText,
  }) : super(key: key);

  final DateTimeController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.selectDate(context),
          child: AbsorbPointer(
            child: Obx(
              () => TextFormField(
                controller:
                    TextEditingController(text: controller.formattedDate),
                // readOnly: true,
                decoration: InputDecoration(
                  labelText: labelText,
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
