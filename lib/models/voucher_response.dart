// To parse this JSON data, do
//
//     final voucherResponse = voucherResponseFromJson(jsonString);

import 'dart:convert';

VoucherResponse voucherResponseFromJson(String str) =>
    VoucherResponse.fromJson(json.decode(str));

String voucherResponseToJson(VoucherResponse data) =>
    json.encode(data.toJson());

class VoucherResponse {
  int? id;
  String? name;
  String? code;
  String? image;
  String? endDate;
  String? description;
  String? decreaseAmount;

  VoucherResponse({
    this.id,
    this.name,
    this.code,
    this.image,
    this.endDate,
    this.description,
    this.decreaseAmount,
  });

  factory VoucherResponse.fromJson(Map<String, dynamic> json) =>
      VoucherResponse(
        id: json["ID"],
        name: json["Name"],
        code: json["Code"],
        image: json["Image"],
        endDate: json["EndDate"],
        description: json["Description"],
        decreaseAmount: json["DecreaseAmount"],
      );

  static List<VoucherResponse> fromJsonList(List<dynamic> jsonList) {
    List<VoucherResponse> toList = [];
    for (var item in jsonList) {
      VoucherResponse response = VoucherResponse.fromJson(item);
      toList.add(response);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
        "Code": code,
        "Image": image,
        "EndDate": endDate,
        "Description": description,
        "DecreaseAmount": decreaseAmount,
      };
}
