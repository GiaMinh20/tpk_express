// To parse this JSON data, do
//
//     final trackingResponse = trackingResponseFromJson(jsonString);

import 'dart:convert';

TrackingResponse trackingResponseFromJson(String str) =>
    TrackingResponse.fromJson(json.decode(str));

String trackingResponseToJson(TrackingResponse data) =>
    json.encode(data.toJson());

class TrackingResponse {
  int? id;
  String? barcode;
  int? status;
  String? dateTq;
  String? dateComingVn;
  String? dateCheck;
  String? dateVn;
  String? dateExport;

  TrackingResponse({
    this.id,
    this.barcode,
    this.status,
    this.dateTq,
    this.dateComingVn,
    this.dateCheck,
    this.dateVn,
    this.dateExport,
  });

  factory TrackingResponse.fromJson(Map<String, dynamic> json) =>
      TrackingResponse(
        id: json["ID"] ?? 0,
        barcode: json["Barcode"] ?? '',
        status: json["Status"] ?? 0,
        dateTq: json["DateTQ"] ?? '',
        dateComingVn: json["DateComingVN"] ?? '',
        dateCheck: json["DateCheck"] ?? '',
        dateVn: json["DateVN"] ?? '',
        dateExport: json["DateExport"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Barcode": barcode,
        "Status": status,
        "DateTQ": dateTq,
        "DateComingVN": dateComingVn,
        "DateCheck": dateCheck,
        "DateVN": dateVn,
        "DateExport": dateExport,
      };
}
