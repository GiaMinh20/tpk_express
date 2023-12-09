// To parse this JSON data, do
//
//     final cancelOrderRequest = cancelOrderRequestFromJson(jsonString);

import 'dart:convert';

import 'base_request.dart';

CancelOrderRequest cancelOrderRequestFromJson(String str) =>
    CancelOrderRequest.fromJson(json.decode(str));

String cancelOrderRequestToJson(CancelOrderRequest data) =>
    json.encode(data.toJson());

class CancelOrderRequest extends BaseRequest {
  int id;
  String reason;

  CancelOrderRequest({
    uid,
    key,
    required this.id,
    required this.reason,
  }) : super(uid: uid, key: key);

  factory CancelOrderRequest.fromJson(Map<String, dynamic> json) =>
      CancelOrderRequest(
        uid: json["UID"],
        key: json["Key"],
        id: json["ID"],
        reason: json["Reason"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "ID": id,
        "Reason": reason,
      };
}
