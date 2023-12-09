// To parse this JSON data, do
//
//     final listTransportationRequest = listTransportationRequestFromJson(jsonString);

import 'dart:convert';

import 'base_request.dart';

NotificationRequest listNotificationRequestFromJson(String str) =>
    NotificationRequest.fromJson(json.decode(str));

String listNotificationRequestToJson(NotificationRequest data) =>
    json.encode(data.toJson());

class NotificationRequest extends BaseRequest {
  int? pageIndex;
  int? type;

  NotificationRequest({
    uid,
    key,
    this.pageIndex,
    this.type,
  }) : super(uid: uid, key: key);

  factory NotificationRequest.fromJson(Map<String, dynamic> json) =>
      NotificationRequest(
        uid: json["UID"],
        key: json["Key"],
        pageIndex: json["PageIndex"],
        type: json["Type"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "PageIndex": pageIndex,
        "Type": type,
      };
}
