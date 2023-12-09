import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpk_express/models/response_api.dart';
import 'package:tpk_express/models/voucher_response.dart';
import 'package:tpk_express/models/warehouse_response.dart';

import '../../../../models/request/create_transportation_request.dart';
import '../../../../models/request/create_transportation_request_element.dart';
import '../../../../models/warehouse_shiptype_response.dart';
import '../../../../providers/webhook_provider.dart';
import '../../../widgets/create_transportation_form_widget.dart';
import '../transportation_controller.dart';

class CreateTransportationController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();
  final TransportationController transportationController = Get.find();
  List<Warehouse> fromWarehouses = <Warehouse>[].obs;
  var idFrom = ''.obs;
  List<Warehouse> vnWarehouses = <Warehouse>[].obs;
  var idVN = ''.obs;
  List<Warehouse> shipTypes = <Warehouse>[].obs;
  var idShip = '1'.obs;
  RxBool isButtonEnabled = true.obs;

  List<CreateTransportationFormWidget> inputForms =
      <CreateTransportationFormWidget>[].obs;
  var barcodeControllers = <TextEditingController>[].obs;
  var noteControllers = <TextEditingController>[].obs;
  var voucherIds = <int>[];
  var listVoucher = <VoucherResponse>[];

  CreateTransportationController() {
    getWarehouseShipType();
  }

  void addVoucher(int id, int voucherId, bool isChecked) {
    CreateTransportationFormWidget? itemToAddVoucher = getItemById(id);
    if (itemToAddVoucher == null) return;
    if (!isChecked) {
      voucherIds.remove(itemToAddVoucher.voucherResponse.value.id);
      itemToAddVoucher.voucherResponse.value =
          listVoucher.firstWhere((element) => element.id == voucherId);
      voucherIds.add(voucherId);
    } else {
      itemToAddVoucher.voucherResponse.value = VoucherResponse();
      voucherIds.remove(voucherId);
    }
    update();
  }

  Future<void> getVoucher() async {
    var listAllVoucher = await webHookProvider.getVouchers();
    listAllVoucher.removeWhere((voucher) => voucherIds.contains(voucher.id));
    listVoucher = listAllVoucher;
  }

  Future<void> addForm() async {
    barcodeControllers.add(TextEditingController());
    noteControllers.add(TextEditingController());
    int index = inputForms.length;
    Rx<VoucherResponse> voucherResponse = VoucherResponse().obs;
    inputForms.add(CreateTransportationFormWidget(
      function: () => removeForm(index),
      barcodeController: barcodeControllers[index],
      noteController: noteControllers[index],
      index: index,
      id: index,
      voucherResponse: voucherResponse,
    ));
    update();
  }

  CreateTransportationFormWidget? getItemById(int id) {
    return inputForms.firstWhereOrNull((widget) => widget.id == id);
  }

  void removeForm(int id) {
    CreateTransportationFormWidget? itemToRemove = getItemById(id);
    if (itemToRemove != null) {
      inputForms.remove(itemToRemove);
      barcodeControllers.remove(itemToRemove.barcodeController);
      noteControllers.remove(itemToRemove.noteController);
      if (voucherIds.contains(itemToRemove.voucherResponse.value.id)) {
        voucherIds.remove(itemToRemove.voucherResponse.value.id);
      }
      update();
    }
  }

  Future<void> getWarehouseShipType() async {
    WarehouseShipType warehouseShipType =
        await webHookProvider.getWarehouseShipType();
    if (warehouseShipType.fromWarehouses != null) {
      fromWarehouses.clear();
      fromWarehouses.addAll(warehouseShipType.fromWarehouses!);
    }
    if (warehouseShipType.vnWarehouses != null) {
      vnWarehouses.clear();
      vnWarehouses.addAll(warehouseShipType.vnWarehouses!);
    }
    if (warehouseShipType.shipTypes != null) {
      shipTypes.clear();
      shipTypes.addAll(warehouseShipType.shipTypes!);
    }
  }

  Future<void> createTransportation() async {
    CreateTransportationRequest createTransportationRequest =
        CreateTransportationRequest();
    createTransportationRequest.fromWarehouse = int.tryParse(idFrom.value) ?? 1;
    createTransportationRequest.vnWarehouse = int.tryParse(idVN.value) ?? 1;
    createTransportationRequest.shipType = int.tryParse(idShip.value) ?? 1;
    createTransportationRequest.createTransportationRequest = [];
    for (var input in inputForms) {
      CreateTransportationRequestElement element =
          CreateTransportationRequestElement();
      element.barcode =
          input.barcodeController!.text.trim().replaceAll(' ', '');
      element.note = input.noteController!.text;
      element.voucherId = input.voucherResponse.value.id ?? 0;
      if (element.barcode!.isNotEmpty) {
        createTransportationRequest.createTransportationRequest?.add(element);
      } else {
        Get.snackbar('Lưu ý', 'Không để trống mã vận đơn');
        return;
      }
    }
    // ResponseApi responseApi =
    //     await webHookProvider.createTransportation(createTransportationRequest);
    // if (responseApi.status == "Success") {
    //   clearLists();
    //   Get.snackbar('Thông báo', responseApi.message ?? 'Tạo đơn thành công');
    //   transportationController.current.value = 0;
    // } else if (responseApi.logout == '1') {
    //   webHookProvider.logOut(responseApi);
    // }
  }

  Future<void> disableButton() async {
    isButtonEnabled.value = false;
    createTransportation();
    isButtonEnabled.value = true;
  }

  void clearLists() {
    inputForms.clear();
    barcodeControllers.clear();
    noteControllers.clear();
    addForm();
    update();
  }
}
