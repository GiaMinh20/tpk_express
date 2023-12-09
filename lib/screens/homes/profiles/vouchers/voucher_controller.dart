import 'package:get/get.dart';

import '../../../../providers/webhook_provider.dart';

class VoucherController extends GetxController {
  var voucherList = [].obs;
  final WebHookProvider webHookProvider = WebHookProvider();

  Future<void> getVoucher() async {
    voucherList.value = (await webHookProvider.getVouchers());
  }
}
