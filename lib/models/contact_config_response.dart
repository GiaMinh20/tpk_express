// To parse this JSON data, do
//
//     final contactConfigResponse = contactConfigResponseFromJson(jsonString);

import 'dart:convert';

ContactConfigResponse contactConfigResponseFromJson(String str) =>
    ContactConfigResponse.fromJson(json.decode(str));

String contactConfigResponseToJson(ContactConfigResponse data) =>
    json.encode(data.toJson());

class ContactConfigResponse {
  String? zaloLink;
  String? hotLine;
  String? insurancePercent;

  ContactConfigResponse({
    this.zaloLink,
    this.hotLine,
    this.insurancePercent,
  });

  factory ContactConfigResponse.fromJson(Map<String, dynamic> json) =>
      ContactConfigResponse(
        zaloLink: json["ZaloLink"],
        hotLine: json["HotLine"],
        insurancePercent: json["InsurancePercent"],
      );

  Map<String, dynamic> toJson() => {
        "ZaloLink": zaloLink,
        "HotLine": hotLine,
        "InsurancePercent": insurancePercent,
      };
}
