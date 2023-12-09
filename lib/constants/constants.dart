import 'package:flutter/material.dart';
import 'package:tpk_express/utilities/convert_color.dart';

class Constants {
  //Primary color
  static var primaryColor = "#f77705".toColor();
  static var blackColor = Colors.black54;

  //Welcome texts
  static var titleOne = "Learn more about plants";
  static var descriptionOne =
      "Read how to care for plants in our rich plants guide.";
  static var titleTwo = "Find a plant lover friend";
  static var descriptionTwo =
      "Are you a plant lover? Connect with other plant lovers.";
  static var titleThree = "Plant a tree, green the Earth";
  static var descriptionThree =
      "Find almost all types of plants that you like here.";

  Color getColorFromInt(int number) {
    Color color;
    switch (number) {
      case 0:
        color = Colors.black54;
        break;
      case 1:
        color = Colors.red;
        break;
      case 2:
        color = Colors.yellow;
        break;
      case 3:
        color = Colors.orange;
        break;
      case 4:
        color = Colors.yellow;
        break;
      case 5:
        color = Colors.purple;
        break;
      case 6:
        color = Colors.green;
        break;
      case 7:
        color = Colors.blueAccent;
        break;
      case 8:
        color = Colors.grey;
        break;
      default:
        color = Colors.green;
    }
    return color;
  }

  IconData getOrderIconFromInt(String notificationMessage) {
    if (notificationMessage.toLowerCase().contains('về kho tq')) {
      return Icons.warehouse;
    }
    else if (notificationMessage.toLowerCase().contains('kiểm hóa')) {
      return Icons.task_rounded;
    }
    else if (notificationMessage.toLowerCase().contains('đang về vn')) {
      return Icons.local_shipping_rounded;
    }
    else if (notificationMessage.toLowerCase().contains('đã về vn') || notificationMessage.toLowerCase().contains('đã về kho vn')) {
      return Icons.warehouse;
    }
    else if (notificationMessage.toLowerCase().contains('voucher')) {
      return Icons.card_membership;
    }
    else{
      return Icons.notifications_none_outlined;
    }
  }

  Color getColorTracking(bool isShow) {
    if (isShow) return primaryColor;
    return Colors.grey;
  }
}
