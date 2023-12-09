import 'package:flutter/material.dart';

class ConfirmAlertDialog extends StatelessWidget {
  const ConfirmAlertDialog(
      {super.key, required this.alertText, required this.confirmFunction});

  final String alertText;
  final Function() confirmFunction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertText),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Tắt AlertDialog khi nút được bấm
          },
          child: const Text('Bỏ qua'),
        ),
        TextButton(
          onPressed: confirmFunction,
          child: const Text('Xác nhận'),
        ),
      ],
    );
  }
}
