import 'dart:convert';

SignInRequest signInRequestFromJson(String str) => SignInRequest.fromJson(json.decode(str));

String signInRequestToJson(SignInRequest data) => json.encode(data.toJson());

class SignInRequest {
  String? username;
  String? password;
  int? type;
  String? deviceToken;
  String? typeName;

  SignInRequest({
    this.username,
    this.password,
    this.type,
    this.deviceToken,
    this.typeName,
  });

  factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
    username: json["Username"],
    password: json["Password"],
    type: json["Type"],
    deviceToken: json["DeviceToken"],
    typeName: json["TypeName"],
  );

  Map<String, dynamic> toJson() => {
    "Username": username,
    "Password": password,
    "Type": type,
    "DeviceToken": deviceToken,
    "TypeName": typeName,
  };
}
