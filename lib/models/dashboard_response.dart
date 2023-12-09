import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {
  int? id;
  String? barCode;
  double? weight;
  double? volume;
  String? status;
  String? createdDate;

  Dashboard({
    this.id,
    this.barCode,
    this.weight,
    this.volume,
    this.status,
    this.createdDate,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
        id: json["ID"] ?? 0,
        barCode: json["Barcode"] ?? 'Không xác định',
        weight: json["Weight"].toDouble() ?? 0,
        volume: json["Volume"].toDouble() ?? 0,
        status: json["Status"] ?? 'Không xác định',
        createdDate: json["CreatedDate"] ?? '00/00/0001',
      );

  static List<Dashboard> fromJsonList(List<dynamic> jsonList) {
    List<Dashboard> toList = [];
    for (var item in jsonList) {
      Dashboard dashboard = Dashboard.fromJson(item);
      toList.add(dashboard);
    }
    return toList;
  }
  Map<String, dynamic> toJson() => {
        "ID": id,
        "BarCode": barCode,
        "Weight": weight,
        "Volume": volume,
        "Status": status,
        "CreatedDate": createdDate,
      };
}
