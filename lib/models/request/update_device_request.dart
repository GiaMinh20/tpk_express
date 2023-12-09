// To parse this JSON data, do
//
//     final UpdateDeviceRequest = UpdateDeviceRequestFromJson(jsonString);

import 'dart:convert';

import 'base_request.dart';

UpdateDeviceRequest updateDeviceRequestFromJson(String str) =>
    UpdateDeviceRequest.fromJson(json.decode(str));

String updateDeviceRequestToJson(UpdateDeviceRequest data) =>
    json.encode(data.toJson());

class UpdateDeviceRequest extends BaseRequest {
  String device;

  UpdateDeviceRequest({
    uid,
    key,
    required this.device,
  }) : super(uid: uid, key: key);

  factory UpdateDeviceRequest.fromJson(Map<String, dynamic> json) =>
      UpdateDeviceRequest(
        uid: json["UID"],
        key: json["Key"],
        device: json["Device"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "Device": device,
      };
}
