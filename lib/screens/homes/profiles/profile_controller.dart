import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/account_info_response.dart';
import '../../../providers/webhook_provider.dart';

class ProfileController extends GetxController {
  final WebHookProvider webHookProvider = WebHookProvider();

  var accountInfo = AccountInfoResponse().obs;

  ProfileController() {
    getAccountInfo();
  }

  Future<void> getAccountInfo() async {
    var result = await webHookProvider.getAccountInfo();
    if (result != null) {
      accountInfo.value = result;
      GetStorage().write('accountInfo', result.toJson());
    }
  }

  void signOut() {
    GetStorage().remove('userData');
    GetStorage().remove('accountInfo');
    Get.offNamedUntil('/signIn', (route) => false);
  }

  Future<void> callHotline() async {
    String number = GetStorage().read('hotline');
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future<void> openZalo() async {
    String url = GetStorage().read('zaloLink');
    Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void gotoUpdateAccountInforScreen() {
    Get.toNamed('/updateAccountInfo');
  }

  void gotoRechargeScreen() {
    Get.toNamed('/recharge');
  }
  void gotoVoucherScreen() {
    Get.toNamed('/voucher');
  }
}
