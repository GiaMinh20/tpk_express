import 'package:flutter/material.dart';

class CancelAlertDialog extends StatelessWidget {
  const CancelAlertDialog(
      {super.key,
      required this.cancelReasonController,
      required this.cancelFunction});

  final TextEditingController cancelReasonController;
  final Function() cancelFunction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hủy đơn hàng'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            labelText: 'Lý do hủy đơn',
          ),
          controller: cancelReasonController,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Bỏ qua'),
        ),
        TextButton(
          onPressed: cancelFunction,
          child: const Text('Xác nhận'),
        ),
      ],
    );
  }
}
