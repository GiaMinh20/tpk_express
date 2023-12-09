// To parse this JSON data, do
//
//     final baseRequest = baseRequestFromJson(jsonString);

import 'dart:convert';

BaseRequest baseRequestFromJson(String str) => BaseRequest.fromJson(json.decode(str));

String baseRequestToJson(BaseRequest data) => json.encode(data.toJson());

class BaseRequest {
  int? uid;
  String? key;

  BaseRequest({
    this.uid,
    this.key,
  });

  factory BaseRequest.fromJson(Map<String, dynamic> json) => BaseRequest(
    uid: json["UID"],
    key: json["Key"],
  );

  Map<String, dynamic> toJson() => {
    "UID": uid,
    "Key": key,
  };
}
