// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromJson(jsonString);

import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) => SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  String? firstName;
  String? lastName;
  String? address;
  String? phone;
  String? email;
  String? birthDay;
  int? gender;
  String? userName;
  String? password;
  String? confirmPassword;

  SignUpRequest({
    this.firstName,
    this.lastName,
    this.address,
    this.phone,
    this.email,
    this.birthDay,
    this.gender,
    this.userName,
    this.password,
    this.confirmPassword,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
    firstName: json["FirstName"],
    lastName: json["LastName"],
    address: json["Address"],
    phone: json["Phone"],
    email: json["Email"],
    birthDay: json["BirthDay"],
    gender: json["Gender"],
    userName: json["UserName"],
    password: json["Password"],
    confirmPassword: json["ConfirmPassword"],
  );

  Map<String, dynamic> toJson() => {
    "FirstName": firstName,
    "LastName": lastName,
    "Address": address,
    "Phone": phone,
    "Email": email,
    "BirthDay": birthDay,
    "Gender": gender,
    "UserName": userName,
    "Password": password,
    "ConfirmPassword": confirmPassword,
  };
}
