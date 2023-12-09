class Warehouse {
  int? id;
  String? name;

  Warehouse({
    this.id,
    this.name,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
    id: json["ID"],
    name: json["Name"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
  };
}