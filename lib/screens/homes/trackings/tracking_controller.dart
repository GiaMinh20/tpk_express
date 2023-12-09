import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tpk_express/models/request/tracking_request.dart';
import 'package:tpk_express/models/tracking_response.dart';

import '../../../models/request/create_tracking_request.dart';
import '../../../models/warehouse_response.dart';
import '../../../models/warehouse_shiptype_response.dart';
import '../../../providers/webhook_provider.dart';

class TrackingController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();
  TextEditingController barcodeController = TextEditingController();
  Timer? searchOnStoppedTyping;
  List<bool> beforeColors = [false, false, false, false, false];
  List<bool> afterColors = [false, false, false, false, false];
  List<bool> iconColors = [false, false, false, false, false];

  var trackingResponse = Rx<TrackingResponse>(TrackingResponse());

  List<Warehouse> vnWarehouses = <Warehouse>[].obs;
  var idVN = ''.obs;

  // var isShowButton = true.obs;

  TextEditingController productNameController = TextEditingController();
  TextEditingController totalShipController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController shipVNController = TextEditingController();
  TextEditingController shipVNVolumeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController shipInVNController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  TrackingController() {
    getWarehouseShipType();
  }

  Future<void> getWarehouseShipType() async {
    WarehouseShipType warehouseShipType =
        await webHookProvider.getWarehouseShipType();
    if (warehouseShipType.vnWarehouses != null) {
      vnWarehouses.clear();
      vnWarehouses.addAll(warehouseShipType.vnWarehouses!);
    }
  }

  void onChangeText(String text) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping = Timer(duration, () {
      if (text.isNotEmpty) {
        tracking(text, 0);
        barcodeController.text = text;
        barcodeController.selection =
            TextSelection.collapsed(offset: text.length);
      } else {
        trackingResponse.value = TrackingResponse();
      }
    });
  }

  Future<void> tracking(String? barcode, int type) async {
    beforeColors = [false, false, false, false, false];
    afterColors = [false, false, false, false, false];
    iconColors = [false, false, false, false, false];
    if (barcode != null && barcode.isNotEmpty) {
      TrackingRequest request = TrackingRequest(barcode: barcode);
      var result = await webHookProvider.tracking(request);
      if (result.id! > 0) {
        trackingResponse.value = result;
        switch (trackingResponse.value.status) {
          case 2:
            iconColors[0] = true;
            afterColors[0] = true;
            break;
          case 3:
            iconColors[0] =
                iconColors[1] = iconColors[2] = iconColors[3] = true;
            afterColors[0] =
                afterColors[1] = afterColors[2] = afterColors[3] = true;
            beforeColors[0] =
                beforeColors[1] = beforeColors[2] = beforeColors[3] = true;
            break;
          case 4:
            iconColors[0] = iconColors[1] =
                iconColors[2] = iconColors[3] = iconColors[4] = true;
            afterColors[0] = afterColors[1] =
                afterColors[2] = afterColors[3] = afterColors[4] = true;
            beforeColors[0] = beforeColors[1] =
                beforeColors[2] = beforeColors[3] = beforeColors[4] = true;
            break;
          case 5:
            iconColors[0] = iconColors[1] = true;
            afterColors[0] = afterColors[1] = true;
            beforeColors[0] = beforeColors[1] = true;
            break;
          case 6:
            iconColors[0] = iconColors[1] = iconColors[2] = true;
            afterColors[0] = afterColors[1] = afterColors[2] = true;
            beforeColors[0] = beforeColors[1] = beforeColors[2] = true;
            break;
          default:
            break;
        }
      } else {
        trackingResponse.value = TrackingResponse();
      }
    }
    if (type == 1) {
      createTracking(barcode);
    } else {
      transOrderDetail(barcode);
    }
    update();
  }

  Future<void> createTracking(String? barcode) async {
    CreateTrackingRequest request = CreateTrackingRequest(
        barcode: barcode ?? '',
        warehouse: int.tryParse(idVN.value) ?? 1,
        productName: productNameController.text,
        totalweight: double.tryParse(weightController.text) ?? 0,
        totalvolume: double.tryParse(volumeController.text) ?? 0,
        number: int.tryParse(numberController.text) ?? 0,
        totalShip: double.tryParse(totalShipController.text) ?? 0,
        shipInVn: double.tryParse(shipInVNController.text) ?? 0,
        note: noteController.text);
    var result = await webHookProvider.createTracking(request);

    productNameController.text = result.productName ?? '';
    totalShipController.text = result.totalShip!.toString();
    weightController.text = result.weight!.toString();
    volumeController.text = result.volume!.toString();
    shipVNController.text =
        NumberFormat.decimalPattern().format(result.shipVn!);
    shipVNVolumeController.text =
        NumberFormat.decimalPattern().format(result.shipVnVolume!);
    numberController.text = result.number!.toString();
    shipInVNController.text = result.shipInVn!.toString();
    unitPriceController.text =
        NumberFormat.decimalPattern().format(result.unitPrice!);
    totalPriceController.text =
        NumberFormat.decimalPattern().format(result.totalPrice!);
    noteController.text = result.note!;
  }

  Future<void> transOrderDetail(String? barcode) async {
    if (barcode != null && barcode.isNotEmpty) {
      TrackingRequest request = TrackingRequest(barcode: barcode);
      var result = await webHookProvider.transOrderDetail(request);

      productNameController.text = result.productName ?? '';
      totalShipController.text = result.totalShip!.toString();
      weightController.text = result.weight!.toString();
      volumeController.text = result.volume!.toString();
      shipVNController.text =
          NumberFormat.decimalPattern().format(result.shipVn!);
      shipVNVolumeController.text =
          NumberFormat.decimalPattern().format(result.shipVnVolume!);
      numberController.text = result.number!.toString();
      shipInVNController.text = result.shipInVn!.toString();
      unitPriceController.text =
          NumberFormat.decimalPattern().format(result.unitPrice!);
      totalPriceController.text =
          NumberFormat.decimalPattern().format(result.totalPrice!);
      noteController.text = result.note!;
    }
  }
}
