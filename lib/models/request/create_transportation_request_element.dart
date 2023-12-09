class CreateTransportationRequestElement {
  String? barcode;
  String? note;
  int? voucherId;

  CreateTransportationRequestElement({this.barcode, this.note, this.voucherId});

  factory CreateTransportationRequestElement.fromJson(
          Map<String, dynamic> json) =>
      CreateTransportationRequestElement(
        barcode: json["Barcode"],
        note: json["Note"],
        voucherId: json["VoucherId"],
      );

  Map<String, dynamic> toJson() => {
        "Barcode": barcode,
        "Note": note,
        "VoucherId": voucherId,
      };
}
