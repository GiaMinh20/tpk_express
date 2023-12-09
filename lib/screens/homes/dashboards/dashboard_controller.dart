import 'package:get/get.dart';

import '../../../providers/webhook_provider.dart';

class DashBoardController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();

  var dashboards = [].obs;

  DashBoardController() {
    getDashboard();
  }

  Future<void> getDashboard() async {
    dashboards.value = (await webHookProvider.getDashboard());
  }

  void gotoTransportationDetail(int id){

  }
}
