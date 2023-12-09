import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpk_express/models/account_info_response.dart';

import '../../../../models/request/cancel_order_request.dart';
import '../../../../models/request/recharge_request.dart';
import '../../../../models/warehouse_response.dart';
import '../../../../providers/webhook_provider.dart';

class RechargeController extends GetxController {
  TextEditingController amountController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  List<Warehouse> banks = <Warehouse>[].obs;
  var bankId = ''.obs;
  var rechargeList = [].obs;

  RxBool isButtonEnabled = true.obs;

  var accountInfo = AccountInfoResponse();
  final WebHookProvider webHookProvider = WebHookProvider();

  RechargeController() {
    accountInfo =
        AccountInfoResponse.fromJson(GetStorage().read('accountInfo'));
    banks.clear();
    banks.addAll([
      Warehouse(
          id: 1,
          name: 'Techcom Bank - VU DINH THOANG - 19035688331012 - Tây Hồ')
    ]);
    contentController.text = 'TPK ${accountInfo.username ?? 'tên đăng nhập'}';
  }

  Future<void> cancelRecharge(int id) async {
    CancelOrderRequest request = CancelOrderRequest(id: id, reason: '');
    var result = await webHookProvider.cancelRecharge(request);
    if (result.status == "Success") {
      Get.back();
      Get.snackbar('Thông báo', 'Hủy thành công');
      getRecharges();
    } else if (result.logout == '1') {
      webHookProvider.logOut(result);
    } else {
      Get.snackbar('Thông báo', 'Có lỗi trong quá trình xử lý');
    }
  }

  Future<void> getRecharges() async {
    Completer<void> completer = Completer<void>();
    rechargeList.value = (await webHookProvider.getRecharges());
    completer.complete();
    await completer.future;
  }

  Future<void> createRecharge(BuildContext context) async {
    String amount = amountController.text.trim();
    String content = contentController.text.trim();
    if (!isValidForm(amount, content)) return;
    RechargeRequest request = RechargeRequest(
        amount: double.parse(amount),
        content: content,
        bankId: int.tryParse(bankId.value) ?? 1);
    if (await webHookProvider.createRecharge(request)) {
      Get.snackbar('Thông báo', 'Tạo yêu cầu thành công');
    } else {
      Get.snackbar('Thông báo', 'Tạo yêu cầu thất bại');
    }
    amountController.clear();
    contentController.clear();
  }

  Future<void> disableButton(BuildContext context) async {
    isButtonEnabled.value = false;
    await createRecharge(context);
    await getRecharges();
    isButtonEnabled.value = true;
  }

  bool isValidForm(String amount, String content) {
    if (amount.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống số tiền');
      return false;
    } else {
      try {
        double.parse(amount);
      } catch (e) {
        return false;
      }
    }
    if (content.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống nội dung');
      return false;
    }
    return true;
  }
}
