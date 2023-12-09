import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeController extends GetxController {
  Future<void> gotoSignInScreen() async {
    OneSignal.consentGiven(true);
    Get.offNamedUntil('/signIn', (route) => false);
  }

  void checkFirstTimeOpened() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    if (isFirstTime) {
      // Nếu là lần đầu tiên mở ứng dụng
      prefs.setBool('first_time', false); // Đánh dấu là đã mở ứng dụng lần đầu
    } else {
      // Nếu không phải là lần đầu tiên mở ứng dụng
      // Chuyển đến màn hình chính hoặc bất kỳ màn hình nào bạn muốn
      Get.offNamedUntil('/signIn', (route) => false);
    }
  }
}
