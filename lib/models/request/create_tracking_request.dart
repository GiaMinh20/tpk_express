// To parse this JSON data, do
//
//     final createTrackingRequest = createTrackingRequestFromJson(jsonString);

import 'dart:convert';

import 'package:tpk_express/models/request/base_request.dart';

CreateTrackingRequest createTrackingRequestFromJson(String str) =>
    CreateTrackingRequest.fromJson(json.decode(str));

String createTrackingRequestToJson(CreateTrackingRequest data) =>
    json.encode(data.toJson());

class CreateTrackingRequest extends BaseRequest {
  String? barcode;
  int? warehouse;
  String? productName;
  num? totalweight;
  num? totalvolume;
  int? number;
  num? totalShip;
  num? shipInVn;
  String? note;

  CreateTrackingRequest({
    uid,
    key,
    this.barcode,
    this.warehouse,
    this.productName,
    this.totalweight,
    this.totalvolume,
    this.number,
    this.totalShip,
    this.shipInVn,
    this.note,
  }) : super(uid: uid, key: key);

  factory CreateTrackingRequest.fromJson(Map<String, dynamic> json) =>
      CreateTrackingRequest(
        uid: json["UID"],
        key: json["Key"],
        barcode: json["Barcode"],
        warehouse: json["Warehouse"],
        productName: json["ProductName"],
        totalweight: json["Totalweight"].toDouble(),
        totalvolume: json["Totalvolume"].toDouble(),
        number: json["Number"],
        totalShip: json["TotalShip"],
        shipInVn: json["ShipInVN"],
        note: json["Note"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "Barcode": barcode,
        "Warehouse": warehouse,
        "ProductName": productName,
        "Totalweight": totalweight,
        "Totalvolume": totalvolume,
        "Number": number,
        "TotalShip": totalShip,
        "ShipInVN": shipInVn,
        "Note": note,
      };
}
