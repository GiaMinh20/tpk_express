import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../models/request/cancel_order_request.dart';
import '../../../../models/request/list_transportation_request.dart';
import '../../../../models/transportation_response.dart';
import '../../../../providers/webhook_provider.dart';
import '../../../widgets/datetime_picker_widget.dart';

class ListTransportationController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();

  var transportations = [].obs;
  List<String> statusName = [
    "Tất Cả",
    "Đơn Mới",
    "Đến Kho TQ",
    "Đã Phát",
    "Kiểm Hóa",
    "Về Kho VN",
    "Đã Xuất Kho",
    "Bộ lọc",
  ];
  List<IconData> iconStatus = [
    Icons.dashboard,
    Icons.wallet,
    Icons.warehouse,
    Icons.local_shipping_rounded,
    Icons.task_rounded,
    Icons.warehouse,
    Icons.thumb_up_alt,
    Icons.filter_alt,
  ];
  int status = -1;
  var type = 0.obs;
  var barcode = ''.obs;
  var currentIndex = 0.obs;
  var totalPage = 1.obs;
  var pageIndex = 0.obs;
  var isFilter = false.obs;
  Timer? searchOnStoppedTyping;
  TextEditingController cancelReasonController = TextEditingController();
  TextEditingController filterContentController = TextEditingController();

  DateTimeController fromDate = DateTimeController();
  DateTimeController toDate = DateTimeController();

  void cancelFilter() {
    getListTransportation(false);
    filterContentController.text = '';
    type.value = 0;
    fromDate = DateTimeController();
    toDate = DateTimeController();
  }

  Future<void> cancelOrder(int id) async {
    CancelOrderRequest request =
        CancelOrderRequest(id: id, reason: cancelReasonController.text);
    var result = await webHookProvider.cancelOrder(request);
    if (result.status == "Success") {
      Get.back();
      Get.snackbar('Thông báo', 'Hủy đơn thành công');
      cancelReasonController.text = '';
      getListTransportation(false);
    } else if (result.logout == '1') {
      webHookProvider.logOut(result);
    } else {
      Get.snackbar('Thông báo', 'Có lỗi trong quá trình xử lý');
    }
  }

  void onChangeText(String text) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping = Timer(duration, () {
      barcode.value = text;
      setStatusByIndex(1);
      getListTransportation(false);
    });
  }

  Future<void> getListTransportation(bool filter) async {
    isFilter.value = filter;
    ListTransportationRequest request = ListTransportationRequest(
        type: type.value,
        code: filterContentController.text,
        pageIndex: pageIndex.value,
        status: status,
        fd: isFilter.value ? fromDate.formattedDate : '',
        td: isFilter.value ? toDate.formattedDate : '');
    var responseApi = await webHookProvider.getListTransportation(request);
    if (responseApi != null) {
      transportations.value =
          TransportationResponse.fromJsonList(responseApi.data);
      totalPage.value =
          (responseApi.totalPage ?? 1) > 0 ? (responseApi.totalPage ?? 1) : 1;
    }
  }

  void setStatusByIndex(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        status = -1;
        break;
      case 1:
        status = 1;
        break;
      case 2:
        status = 3;
        break;
      case 3:
        status = 7;
        break;
      case 4:
        status = 8;
        break;
      case 5:
        status = 4;
        break;
      case 6:
        status = 6;
        break;
      default:
        status = -1;
        break;
    }
    pageIndex.value = 0;
    getListTransportation(false);
  }
}
