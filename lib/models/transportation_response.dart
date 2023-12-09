// To parse this JSON data, do
//
//     final transportationResponse = transportationResponseFromJson(jsonString);

import 'dart:convert';

TransportationResponse transportationResponseFromJson(String str) =>
    TransportationResponse.fromJson(json.decode(str));

String transportationResponseToJson(TransportationResponse data) =>
    json.encode(data.toJson());

class TransportationResponse {
  int? id;
  String? barcode;
  String? statusName;
  int? status;
  num? weight;
  num? volume;
  int? quantity;
  String? vnWarehouse;
  String? fromWarehouse;
  String? shippingType;
  String? note;
  String? sensorFeeeVnd;
  String? createdDate;
  String? dateExport;
  String? exportRequestNote;
  String? warning;

  TransportationResponse({
    this.id,
    this.barcode,
    this.statusName,
    this.status,
    this.weight,
    this.volume,
    this.quantity,
    this.vnWarehouse,
    this.fromWarehouse,
    this.shippingType,
    this.note,
    this.sensorFeeeVnd,
    this.createdDate,
    this.dateExport,
    this.exportRequestNote,
    this.warning,
  });

  factory TransportationResponse.fromJson(Map<String, dynamic> json) =>
      TransportationResponse(
        id: json["ID"],
        barcode: json["Barcode"],
        statusName: json["StatusName"],
        status: json["Status"],
        weight: json["Weight"] ?? 0,
        volume: json["Volume"] ?? 0,
        quantity: json["Quantity"] ?? 0,
        vnWarehouse: json["VNWarehouse"] ?? '',
        fromWarehouse: json["FromWarehouse"] ?? '',
        shippingType: json["ShippingType"] ?? '',
        note: json["Note"] ?? '',
        sensorFeeeVnd: json["SensorFeeeVND"] ?? '',
        createdDate: json["CreatedDate"] ?? '',
        dateExport: json["DateExport"] ?? '',
        exportRequestNote: json["ExportRequestNote"] ?? '',
        warning: json["Warning"] ?? '',
      );

  static List<TransportationResponse> fromJsonList(List<dynamic> jsonList) {
    List<TransportationResponse> toList = [];
    for (var item in jsonList) {
      TransportationResponse transportationResponse =
          TransportationResponse.fromJson(item);
      toList.add(transportationResponse);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Barcode": barcode,
        "StatusName": statusName,
        "Status": status,
        "Weight": weight,
        "Volume": volume,
        "Quantity": quantity,
        "VNWarehouse": vnWarehouse,
        "FromWarehouse": fromWarehouse,
        "ShippingType": shippingType,
        "Note": note,
        "SensorFeeeVND": sensorFeeeVnd,
        "CreatedDate": createdDate,
        "DateExport": dateExport,
        "ExportRequestNote": exportRequestNote,
        "Warning": warning,
      };
}
