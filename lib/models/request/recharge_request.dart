// To parse this JSON data, do
//
//     final rechargeRequest = rechargeRequestFromJson(jsonString);

import 'dart:convert';

RechargeRequest rechargeRequestFromJson(String str) =>
    RechargeRequest.fromJson(json.decode(str));

String rechargeRequestToJson(RechargeRequest data) =>
    json.encode(data.toJson());

class RechargeRequest {
  int? uid;
  String? key;
  int? bankId;
  num? amount;
  String? content;

  RechargeRequest({
    this.uid,
    this.key,
    this.amount,
    this.content,
    this.bankId,
  });

  factory RechargeRequest.fromJson(Map<String, dynamic> json) =>
      RechargeRequest(
        uid: json["UID"],
        key: json["Key"],
        amount: json["Amount"],
        content: json["Content"],
        bankId: json["BankId"],
      );

  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "Amount": amount,
        "Content": content,
        "BankId": bankId,
      };
}
