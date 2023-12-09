// To parse this JSON data, do
//
//     final accountInfoResponse = accountInfoResponseFromJson(jsonString);

import 'dart:convert';

AccountInfoResponse accountInfoResponseFromJson(String str) =>
    AccountInfoResponse.fromJson(json.decode(str));

String accountInfoResponseToJson(AccountInfoResponse data) =>
    json.encode(data.toJson());

class AccountInfoResponse {
  String? username;
  String? firstName;
  String? lastName;
  int? gender;
  String? dob;
  int? toWarehouseId;
  int? fromWarehouseId;
  int? shipType;
  String? address;
  String? avatar;
  String? email;
  String? phone;
  String? wallet;

  AccountInfoResponse({
    this.username,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.toWarehouseId,
    this.fromWarehouseId,
    this.shipType,
    this.address,
    this.avatar,
    this.email,
    this.phone,
    this.wallet,
  });

  factory AccountInfoResponse.fromJson(Map<String, dynamic> json) =>
      AccountInfoResponse(
        username: json["Username"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        gender: json["Gender"],
        dob: json["Dob"],
        toWarehouseId: json["ToWarehouseId"],
        fromWarehouseId: json["FromWarehouseId"],
        shipType: json["ShipType"],
        address: json["Address"],
        avatar: json["Avatar"],
        email: json["Email"],
        phone: json["Phone"],
        wallet: json["Wallet"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "Username": username,
        "FirstName": firstName,
        "LastName": lastName,
        "Gender": gender,
        "Dob": dob,
        "ToWarehouseId": toWarehouseId,
        "FromWarehouseId": fromWarehouseId,
        "ShipType": shipType,
        "Address": address,
        "Avatar": avatar,
        "Email": email,
        "Phone": phone,
        "Wallet": wallet,
      };
}
