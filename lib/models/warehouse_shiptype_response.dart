// To parse this JSON data, do
//
//     final warehouseShipType = warehouseShipTypeFromJson(jsonString);

import 'dart:convert';

import 'warehouse_response.dart';

WarehouseShipType warehouseShipTypeFromJson(String str) =>
    WarehouseShipType.fromJson(json.decode(str));

String warehouseShipTypeToJson(WarehouseShipType data) =>
    json.encode(data.toJson());

class WarehouseShipType {
  List<Warehouse>? vnWarehouses;
  List<Warehouse>? fromWarehouses;
  List<Warehouse>? shipTypes;

  WarehouseShipType({
    this.vnWarehouses,
    this.fromWarehouses,
    this.shipTypes,
  });

  factory WarehouseShipType.fromJson(Map<String, dynamic> json) =>
      WarehouseShipType(
        vnWarehouses: List<Warehouse>.from(
            json["VNWarehouses"].map((x) => Warehouse.fromJson(x))),
        fromWarehouses: List<Warehouse>.from(
            json["FromWarehouses"].map((x) => Warehouse.fromJson(x))),
        shipTypes: List<Warehouse>.from(
            json["ShipTypes"].map((x) => Warehouse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "VNWarehouses":
            List<dynamic>.from(vnWarehouses!.map((x) => x.toJson())),
        "FromWarehouses":
            List<dynamic>.from(fromWarehouses!.map((x) => x.toJson())),
        "ShipTypes": List<dynamic>.from(shipTypes!.map((x) => x.toJson())),
      };
}
