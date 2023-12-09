// To parse this JSON data, do
//
//     final listTransportationRequest = listTransportationRequestFromJson(jsonString);

import 'dart:convert';

import 'base_request.dart';

ListTransportationRequest listTransportationRequestFromJson(String str) => ListTransportationRequest.fromJson(json.decode(str));

String listTransportationRequestToJson(ListTransportationRequest data) => json.encode(data.toJson());

class ListTransportationRequest extends BaseRequest{
  int? pageIndex;
  String? code;
  int? type;
  int? status;
  String? fd;
  String? td;

  ListTransportationRequest({
    uid,
    key,
    this.pageIndex,
    this.code,
    this.type,
    this.status,
    this.fd,
    this.td,
  }): super(uid: uid, key: key);

  factory ListTransportationRequest.fromJson(Map<String, dynamic> json) => ListTransportationRequest(
    uid: json["UID"],
    key: json["Key"],
    pageIndex: json["PageIndex"],
    code: json["Code"],
    type: json["Type"],
    status: json["Status"],
    fd: json["FD"],
    td: json["TD"],
  );


  @override
  Map<String, dynamic> toJson() => {
    "UID": uid,
    "Key": key,
    "PageIndex": pageIndex,
    "Code": code,
    "Type": type,
    "Status": status,
    "FD": fd,
    "TD": td,
  };
}
