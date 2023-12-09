class AccountResponse {
  int? id;
  String? username;
  int? role;

  AccountResponse({
    this.id,
    this.username,
    this.role,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) => AccountResponse(
    id: json["ID"],
    username: json["Username"],
    role: json["Role"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Username": username,
    "Role": role,
  };
}