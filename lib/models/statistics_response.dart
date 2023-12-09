// To parse this JSON data, do
//
//     final statisticResponse = statisticResponseFromJson(jsonString);

import 'dart:convert';

StatisticResponse statisticResponseFromJson(String str) =>
    StatisticResponse.fromJson(json.decode(str));

String statisticResponseToJson(StatisticResponse data) =>
    json.encode(data.toJson());

class StatisticResponse {
  int? id;
  String? dateRequest;
  List<StatisticResponseElement>? statisticResponseElements;
  int? quantity;
  double? weight;
  double? volume;
  String? totalPriceVnd;
  String? statusPaymentName;
  String? statusExportName;
  int? statusPayment;
  int? statusExport;
  String? staffNote;

  StatisticResponse({
    this.id,
    this.dateRequest,
    this.statisticResponseElements,
    this.quantity,
    this.weight,
    this.volume,
    this.totalPriceVnd,
    this.statusPaymentName,
    this.statusExportName,
    this.statusPayment,
    this.statusExport,
    this.staffNote,
  });

  factory StatisticResponse.fromJson(Map<String, dynamic> json) =>
      StatisticResponse(
        id: json["ID"],
        dateRequest: json["DateRequest"],
        statisticResponseElements: List<StatisticResponseElement>.from(
            json["StatisticResponseElements"]
                .map((x) => StatisticResponseElement.fromJson(x))),
        quantity: json["Quantity"],
        weight: json["Weight"],
        volume: json["Volume"],
        totalPriceVnd: json["TotalPriceVND"],
        statusPaymentName: json["StatusPaymentName"],
        statusExportName: json["StatusExportName"],
        statusPayment: json["StatusPayment"],
        statusExport: json["StatusExport"],
        staffNote: json["StaffNote"],
      );

  static List<StatisticResponse> fromJsonList(List<dynamic> jsonList) {
    List<StatisticResponse> toList = [];
    for (var item in jsonList) {
      StatisticResponse statisticResponse = StatisticResponse.fromJson(item);
      toList.add(statisticResponse);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "ID": id,
        "DateRequest": dateRequest,
        "StatisticResponseElements": List<dynamic>.from(
            statisticResponseElements!.map((x) => x.toJson())),
        "Quantity": quantity,
        "Weight": weight,
        "Volume": volume,
        "TotalPriceVND": totalPriceVnd,
        "StatusPaymentName": statusPaymentName,
        "StatusExportName": statusExportName,
        "StatusPayment": statusPayment,
        "StatusExport": statusExport,
        "StaffNote": staffNote,
      };
}

class StatisticResponseElement {
  String? barcode;
  String? dateExport;

  StatisticResponseElement({
    this.barcode,
    this.dateExport,
  });

  factory StatisticResponseElement.fromJson(Map<String, dynamic> json) =>
      StatisticResponseElement(
        barcode: json["Barcode"],
        dateExport: json["DateExport"],
      );

  Map<String, dynamic> toJson() => {
        "Barcode": barcode,
        "DateExport": dateExport,
      };
}
