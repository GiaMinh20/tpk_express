import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  int? uid;
  String? key;
  String? username;

  UserData({
    this.uid,
    this.key,
    this.username,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json["UID"],
        key: json["Key"],
        username: json["Username"],
      );

  Map<String, dynamic> toJson() => {
        "UID": uid,
        "Key": key,
        "Username": username,
      };
}
