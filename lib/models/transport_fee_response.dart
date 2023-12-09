// To parse this JSON data, do
//
//     final transportFeeResponse = transportFeeResponseFromJson(jsonString);

import 'dart:convert';

TransportFeeResponse transportFeeResponseFromJson(String str) =>
    TransportFeeResponse.fromJson(json.decode(str));

String transportFeeResponseToJson(TransportFeeResponse data) =>
    json.encode(data.toJson());

class TransportFeeResponse {
  String? productName;
  num? totalShip;
  num? weight;
  num? volume;
  num? shipVn;
  num? shipVnVolume;
  num? number;
  num? shipInVn;
  num? unitPrice;
  num? totalPrice;
  String? note;

  TransportFeeResponse({
    this.productName,
    this.totalShip,
    this.weight,
    this.volume,
    this.shipVn,
    this.shipVnVolume,
    this.number,
    this.shipInVn,
    this.unitPrice,
    this.totalPrice,
    this.note,
  });

  factory TransportFeeResponse.fromJson(Map<String, dynamic> json) =>
      TransportFeeResponse(
        productName: json["ProductName"],
        totalShip: json["TotalShip"],
        weight: json["Weight"].toDouble(),
        volume: json["Volume"].toDouble(),
        shipVn: json["ShipVn"].toDouble(),
        shipVnVolume: json["ShipVnVolume"].toDouble(),
        number: json["Number"],
        shipInVn: json["ShipInVn"],
        unitPrice: json["UnitPrice"],
        totalPrice: json["TotalPrice"],
        note: json["Note"],
      );

  Map<String, dynamic> toJson() => {
        "ProductName": productName,
        "TotalShip": totalShip,
        "Weight": weight,
        "Volume": volume,
        "ShipVn": shipVn,
        "ShipVnVolume": shipVnVolume,
        "Number": number,
        "ShipInVn": shipInVn,
        "UnitPrice": unitPrice,
        "TotalPrice": totalPrice,
        "Note": note,
      };
}
