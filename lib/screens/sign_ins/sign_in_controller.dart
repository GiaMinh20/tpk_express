import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tpk_express/models/request/update_device_request.dart';
import 'package:tpk_express/models/user_data.dart';

import '../../models/request/sign_in_request.dart';
import '../../models/response_api.dart';
import '../../providers/webhook_provider.dart';

class SignInController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RxBool isButtonEnabled = true.obs;

  final WebHookProvider webHookProvider = WebHookProvider();

  Future<void> signIn() async {
    String username = usernameController.text.toLowerCase().trim();
    String password = passwordController.text.trim();

    if (isValidForm(username, password)) {
      int type = 0;
      String typeName = 'Không xác định';
      if (Platform.isAndroid) {
        type = 2;
        typeName = 'Android';
      } else if (Platform.isIOS) {
        type = 1;
        typeName = 'IOS';
      }
      SignInRequest request = SignInRequest(
        username: username,
        password: password,
        type: type,
        typeName: typeName,
        deviceToken: "",
      );

      ResponseApi responseApi = await webHookProvider.signIn(request);
      if (responseApi.status == "Success") {
        Get.offNamedUntil('/root', (route) => false);
        UserData userData = UserData(
            uid: responseApi.account?.id,
            username: responseApi.account?.username,
            key: responseApi.key);
        GetStorage().write('userData', userData.toJson());
        GetStorage().remove('logout');

        gotoRootScreen(userData.uid!, userData.key!);
      } else {
        Get.snackbar('Đăng nhập thất bại', responseApi.message ?? '');
      }
    }
  }

  bool isValidForm(String username, String password) {
    if (username.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống tài khoản');
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar('Error', 'Không để trống mật khẩu');
      return false;
    }
    return true;
  }

  Future<void> disableButton() async {
    isButtonEnabled.value = false;

    await signIn(); // Đợi cho signIn() hoàn thành

    await Future.delayed(Duration.zero);

    isButtonEnabled.value = true;
  }

  void gotoSignUpScreen() {
    Get.toNamed('/signUp');
  }

  void gotoForgotPasswordScreen() {
    Get.toNamed('/forgotPassword');
  }

  Future<void> gotoRootScreen(int uid, String key) async {
    Completer<void> completer = Completer<void>();
    if (OneSignal.User.pushSubscription.id != null) {
      String id = OneSignal.User.pushSubscription.id!;
      UpdateDeviceRequest request =
          UpdateDeviceRequest(device: id, uid: uid, key: key);
      await webHookProvider.updateDevice(request);
      completer.complete();
    } else {
      completer.complete();
    }
    await completer.future;
  }
}
