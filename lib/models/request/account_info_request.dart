// To parse this JSON data, do
//
//     final accountInfoRequest = accountInfoRequestFromJson(jsonString);

import 'dart:convert';

AccountInfoRequest accountInfoRequestFromJson(String str) =>
    AccountInfoRequest.fromJson(json.decode(str));

String accountInfoRequestToJson(AccountInfoRequest data) =>
    json.encode(data.toJson());

class AccountInfoRequest {
  int? uid;
  String? key;
  String? firstName;
  String? lastName;
  int? gender;
  int? toWarehouseId;
  int? fromWarehouseId;
  int? shipType;
  String? address;
  String? avatar;
  String? password;

  AccountInfoRequest({
    this.uid,
    this.key,
    this.firstName,
    this.lastName,
    this.gender,
    this.toWarehouseId,
    this.fromWarehouseId,
    this.shipType,
    this.address,
    this.avatar,
    this.password,
  });

  factory AccountInfoRequest.fromJson(Map<String, dynamic> json) =>
      AccountInfoRequest(
        firstName: json["FirstName"],
        lastName: json["LastName"],
        gender: json["Gender"],
        toWarehouseId: json["ToWarehouseId"],
        fromWarehouseId: json["FromWarehouseId"],
        shipType: json["ShipType"],
        address: json["Address"],
        avatar: json["Avatar"],
        password: json["Password"],
      );

  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "FirstName": firstName,
        "LastName": lastName,
        "Gender": gender,
        "ToWarehouseId": toWarehouseId,
        "FromWarehouseId": fromWarehouseId,
        "ShipType": shipType,
        "Address": address,
        "Avatar": avatar,
        "Password": password,
      };
}
