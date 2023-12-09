import 'dart:convert';

import 'account_response.dart';

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  String? code;
  String? status;
  String? key;
  String? message;
  dynamic data;
  AccountResponse? account;
  int? totalPage;
  String? logout;

  ResponseApi({
    this.code,
    this.status,
    this.key,
    this.message,
    this.data,
    this.account,
    this.totalPage,
    this.logout,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
        code: json["Code"],
        status: json["Status"],
        key: json["Key"],
        message: json["Message"],
        data: json['data'] ?? json['Data'],
        account: json["Account"] != null
            ? AccountResponse.fromJson(json["Account"])
            : null,
        totalPage: json['totalPage'] ?? json['TotalPage'],
        logout: json["Logout"],
      );

  Map<String, dynamic> toJson() => {
        "Code": code,
        "Status": status,
        "Key": key,
        "Message": message,
        "Data": data,
        "Account": account?.toJson(),
        "TotalPage": totalPage,
        "Logout": logout,
      };
}
