// To parse this JSON data, do
//
//     final createTransportationRequest = createTransportationRequestFromJson(jsonString);

import 'dart:convert';

import 'base_request.dart';
import 'create_transportation_request_element.dart';

CreateTransportationRequest createTransportationRequestFromJson(String str) =>
    CreateTransportationRequest.fromJson(json.decode(str));

String createTransportationRequestToJson(CreateTransportationRequest data) =>
    json.encode(data.toJson());

class CreateTransportationRequest extends BaseRequest {
  int? fromWarehouse;
  int? vnWarehouse;
  int? shipType;
  List<CreateTransportationRequestElement>? createTransportationRequest;

  CreateTransportationRequest({
    uid,
    key,
    this.fromWarehouse,
    this.vnWarehouse,
    this.shipType,
    this.createTransportationRequest,
  }) : super(uid: uid, key: key);

  factory CreateTransportationRequest.fromJson(Map<String, dynamic> json) =>
      CreateTransportationRequest(
        uid: json["UID"],
        key: json["Key"],
        fromWarehouse: json["FromWarehouse"],
        vnWarehouse: json["VNWarehouse"],
        shipType: json["ShipType"],
        createTransportationRequest:
            List<CreateTransportationRequestElement>.from(
                json["TransportationRequests"].map(
                    (x) => CreateTransportationRequestElement.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "FromWarehouse": fromWarehouse,
        "VNWarehouse": vnWarehouse,
        "ShipType": shipType,
        "TransportationRequests": List<dynamic>.from(
            createTransportationRequest!.map((x) => x.toJson())),
      };
}
