// To parse this JSON data, do
//
//     final recharge = rechargeFromJson(jsonString);

import 'dart:convert';

RechargeResponse rechargeFromJson(String str) =>
    RechargeResponse.fromJson(json.decode(str));

String rechargeResponse(RechargeResponse data) => json.encode(data.toJson());

class RechargeResponse {
  int? id;
  String? createdDate;
  String? amount;
  String? tradeContent;
  String? statusName;
  int? status;
  String? currentWallet;
  String? amountRecharged;

  RechargeResponse({
    this.id,
    this.createdDate,
    this.amount,
    this.tradeContent,
    this.statusName,
    this.status,
    this.currentWallet,
    this.amountRecharged,
  });

  factory RechargeResponse.fromJson(Map<String, dynamic> json) =>
      RechargeResponse(
        id: json["ID"] ?? 0,
        createdDate: json["CreatedDate"] ?? "",
        amount: json["Amount"] ?? 0,
        tradeContent: json["TradeContent"] ?? "",
        statusName: json["StatusName"] ?? "",
        currentWallet: json["CurrentWallet"] ?? "",
        amountRecharged: json["AmountRecharged"] ?? "",
        status: json["Status"] ?? -1,
      );

  static List<RechargeResponse> fromJsonList(List<dynamic> jsonList) {
    List<RechargeResponse> toList = [];
    for (var item in jsonList) {
      RechargeResponse response = RechargeResponse.fromJson(item);
      toList.add(response);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CreatedDate": createdDate,
        "Amount": amount,
        "TradeContent": tradeContent,
        "StatusName": statusName,
        "Status": status,
        "CurrentWallet": currentWallet,
        "AmountRecharged": amountRecharged,
      };
}
