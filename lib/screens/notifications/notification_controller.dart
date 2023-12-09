import 'package:get/get.dart';
import 'package:tpk_express/models/notification_response.dart';

import '../../models/request/notification_request.dart';
import '../../providers/webhook_provider.dart';
import 'notification_type_screen/notification_type_list_screen.dart';

class NotificationController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();

  var pageIndex = 0.obs;
  var totalPage = 1.obs;
  var notifications = [].obs;

  Future<void> getNotification() async {
    NotificationRequest request = NotificationRequest(
      pageIndex: pageIndex.value,
      type: 0
    );
    var responseApi = await webHookProvider.getListNotification(request);
    if (responseApi != null) {
      var rs = NotificationResponse.fromJsonList(responseApi.data);
      notifications.value = rs.take(7).toList();
      totalPage.value =
          (responseApi.totalPage ?? 1) > 0 ? (responseApi.totalPage ?? 1) : 1;
    }
  }

  void gotoNotificationType(int type) {
    Get.to(() => NotificationTypeListScreen(
          type: type,
        ));
  }
}
