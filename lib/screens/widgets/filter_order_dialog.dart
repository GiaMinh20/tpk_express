import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'datetime_picker_widget.dart';

class FilterOrderDialog extends StatelessWidget {
  const FilterOrderDialog(
      {super.key,
      required this.searchContentController,
      required this.filterFunction,
      required this.selectedValue,
      required this.fromDate,
      required this.toDate,
      required this.cancelFilterFunction});

  final TextEditingController searchContentController;
  final VoidCallback filterFunction;
  final VoidCallback cancelFilterFunction;
  final RxInt selectedValue;
  final DateTimeController fromDate;
  final DateTimeController toDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Obx(
                () => DropdownButton<int>(
                  value: selectedValue.value,
                  onChanged: (newValue) {
                    selectedValue.value = newValue!;
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Tất cả'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('Mã vận đơn'),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text('ID đơn'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  labelText: 'Mã vận đơn/ ID đơn',
                ),
                controller: searchContentController,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DateTimePicker(
                labelText: "Từ ngày",
                controller: fromDate,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DateTimePicker(
                labelText: "Đến ngày",
                controller: toDate,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            filterFunction();
            Navigator.pop(context); // Tắt AlertDialog khi nút được bấm
          },
          child: const Text('Tìm kiếm'),
        ),
        TextButton(
          onPressed: () {
            cancelFilterFunction();
            Navigator.pop(context); // Tắt AlertDialog khi nút được bấm
          },
          child: const Text('Xóa lọc'),
        ),
      ],
    );
  }
}
