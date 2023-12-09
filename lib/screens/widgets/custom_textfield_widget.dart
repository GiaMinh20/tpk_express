import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final IconData? icon;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Color? itemColor;
  final InputBorder? inputBorder;
  const CustomTextField({
    Key? key,
    this.icon,
    required this.obscureText,
    this.hintText,
    this.controller,
    this.textInputType,
    this.labelText,
    this.itemColor,
    this.inputBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: itemColor ?? Constants.blackColor,
      ),
      decoration: InputDecoration(
        border: inputBorder ?? const UnderlineInputBorder(),
        prefixIcon: Icon(
          icon,
          color: itemColor ?? Constants.blackColor,
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: itemColor ?? Constants.blackColor),
        hintStyle: TextStyle(color: itemColor ?? Constants.blackColor),
      ),
      cursorColor: itemColor ?? Constants.blackColor,
      keyboardType: textInputType ?? TextInputType.text,
    );
  }
}
