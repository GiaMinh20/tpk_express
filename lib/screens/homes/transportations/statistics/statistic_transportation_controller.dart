import 'package:get/get.dart';

import '../../../../models/request/cancel_order_request.dart';
import '../../../../providers/webhook_provider.dart';

class StatisticTransportationController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();

  var statistics = [].obs;

  Future<void> getStatistic() async {
    statistics.value = (await webHookProvider.getStatistic());
  }

  Future<void> paymentStatistic(int id) async {
    CancelOrderRequest request = CancelOrderRequest(id: id, reason: 'aaa');
    var result = await webHookProvider.paymentStatistic(request);
    if (result.status == "Success") {
      Get.back();
      Get.snackbar('Thông báo', 'Thanh toán thành công');
      getStatistic();
    } else if (result.logout == '1') {
      webHookProvider.logOut(result);
    } else {
      Get.back();
      Get.snackbar(
          'Thông báo',
          result.message != null
              ? result.message!
              : 'Có lỗi trong quá trình xử lý');
    }
  }
}
