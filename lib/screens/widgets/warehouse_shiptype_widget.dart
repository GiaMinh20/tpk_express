import 'package:flutter/material.dart';
import 'package:tpk_express/constants/constants.dart';

import '../../models/warehouse_response.dart';

class WarehouseDropDownWidget extends StatelessWidget {
  final List<Warehouse> warehouse;
  final String? value;
  final ValueChanged<String?>? onChanged;
  final String? hintText;

  const WarehouseDropDownWidget(
      {super.key,
      required this.warehouse,
      this.value,
      this.onChanged,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton(
        underline: Container(
          alignment: Alignment.centerRight,
          child:
              Icon(Icons.arrow_drop_down_circle, color: Constants.primaryColor),
        ),
        borderRadius: BorderRadius.circular(10),
        dropdownColor: Colors.orangeAccent,
        elevation: 3,
        isExpanded: true,
        hint: Text(
          hintText!,
          style: const TextStyle(fontSize: 16),
        ),
        items: _dropDownItems(warehouse),
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Warehouse> listData) {
    List<DropdownMenuItem<String>> list = [];
    for (var data in listData) {
      list.add(DropdownMenuItem(
        value: data.id != null ? data.id!.toString() : '1',
        child: Text(data.name ?? ''),
      ));
    }
    return list;
  }
}
