import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpk_express/screens/notifications/notification_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/webhook_provider.dart';
import '../homes/profiles/profile_screen.dart';
import '../homes/trackings/tracking_screen.dart';
import '../homes/transportations/lists/list_transportation_screen.dart';
import '../homes/transportations/transportation_screen.dart';

class RootController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();

  var bottomNavIndex = 0.obs;
  var countNotification = 0.obs;

  List<Widget> widgetOptions() {
    return [
      ListTransportationScreen(),
      TransportationScreen(),
      TrackingScreen(),
      ProfileScreen(),
    ];
  }

  List<IconData> iconList = [
    Icons.dashboard,
    Icons.fire_truck_sharp,
    Icons.search_outlined,
    Icons.person_rounded,
    Icons.message_outlined,
  ];

  Future<void> getTotalNotification() async {
    var responseApi = await webHookProvider.getTotalNotification();
    if (responseApi != null) {
      countNotification.value = responseApi.totalPage ?? 0;
    }
  }

  Future<void> openZalo(BuildContext context) async {
    String url = GetStorage().read('zaloLink');
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  // Future<void> callHotline() async {
  //   String number = GetStorage().read('hotline');
  //   await FlutterPhoneDirectCaller.callNumber(number);
  // }

  void gotoNotification() {
    Get.to(() => NotificationScreen());
  }
}
