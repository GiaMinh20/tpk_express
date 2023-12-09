import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/response_api.dart';
import '../../providers/webhook_provider.dart';
import '../sign_ins/sign_in_controller.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  RxBool isButtonEnabled = true.obs;

  final WebHookProvider webHookProvider = WebHookProvider();
  final SignInController signInController = Get.find();

  Future<void> signUp() async {
    String email = emailController.text.trim();
    if (isValidForm(email)) {
      ResponseApi responseApi = await webHookProvider.forgotPassword(email);
      if (responseApi.status == "Success") {
        Get.snackbar('Thông báo', 'Mật khẩu đã được gửi vào mail của bạn');
      } else {
        Get.snackbar('Yêu cầu thất bại', responseApi.message ?? '');
      }
    }
  }

  bool isValidForm(String email) {
    if(!email.isEmail){
      Get.snackbar('Lưu ý', 'Email không đúng định dạng');
      return false;
    }
    if (email.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống Email');
      return false;
    }

    return true;
  }

  Future<void> disableButton() async {
    isButtonEnabled.value = false;

    await signUp();

    isButtonEnabled.value = true;
  }

  void gotoSignInScreen() {
    Get.offNamedUntil('/signIn', (route) => false);
  }

  void gotoRootScreen() {
    Get.offNamedUntil('/root', (route) => false);
  }
}
