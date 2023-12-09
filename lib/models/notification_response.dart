// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) =>
    NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) =>
    json.encode(data.toJson());

class NotificationResponse {
  String? message;
  DateTime? createdDate;
  String? title;
  int? type;

  NotificationResponse({
    this.message,
    this.createdDate,
    this.title,
    this.type,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      NotificationResponse(
        message: json["Message"],
        createdDate: DateTime.parse(json["CreatedDate"]),
        title: json["Title"] ?? 'Thông báo',
        type: json["Type"] ?? 0,
      );

  static List<NotificationResponse> fromJsonList(List<dynamic> jsonList) {
    List<NotificationResponse> toList = [];
    for (var item in jsonList) {
      NotificationResponse notificationResponse =
          NotificationResponse.fromJson(item);
      toList.add(notificationResponse);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "Message": message,
        "CreatedDate": createdDate?.toString(),
        "Title": title,
        "Type": type,
      };
}
