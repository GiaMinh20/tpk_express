// To parse this JSON data, do
//
//     final trackingRequest = trackingRequestFromJson(jsonString);

import 'dart:convert';

import 'base_request.dart';

TrackingRequest trackingRequestFromJson(String str) =>
    TrackingRequest.fromJson(json.decode(str));

String trackingRequestToJson(TrackingRequest data) =>
    json.encode(data.toJson());

class TrackingRequest extends BaseRequest {
  String? barcode;

  TrackingRequest({
    uid,
    key,
    this.barcode,
  }) : super(uid: uid, key: key);

  factory TrackingRequest.fromJson(Map<String, dynamic> json) =>
      TrackingRequest(
        uid: json["UID"],
        key: json["Key"],
        barcode: json["Barcode"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "Barcode": barcode,
      };
}
