import 'package:get/get.dart';
import 'package:tpk_express/models/notification_response.dart';

import '../../../models/request/notification_request.dart';
import '../../../providers/webhook_provider.dart';

class NotificationTypeController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();
  var pageIndex = 0.obs;
  var totalPage = 1.obs;
  var notifications = [].obs;

  Future<void> getNotification(int type) async {
    NotificationRequest request = NotificationRequest(
      pageIndex: pageIndex.value,
      type: type,
    );
    var responseApi = await webHookProvider.getListNotification(request);
    if (responseApi != null) {
      notifications.value = NotificationResponse.fromJsonList(responseApi.data);
      totalPage.value =
          (responseApi.totalPage ?? 1) > 0 ? (responseApi.totalPage ?? 1) : 1;
    }
  }
}
