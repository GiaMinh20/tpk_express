import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/request/sign_up_request.dart';
import '../../models/response_api.dart';
import '../../providers/webhook_provider.dart';
import '../sign_ins/sign_in_controller.dart';

class SignUpController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RxBool isButtonEnabled = true.obs;

  final WebHookProvider webHookProvider = WebHookProvider();
  final SignInController signInController = Get.find();

  Future<void> signUp() async {
    String username = usernameController.text.toLowerCase().trim();
    String firstName = firstNameController.text.toLowerCase().trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.toLowerCase().trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    SignUpRequest request = SignUpRequest(
      userName: username,
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      password: password,
      confirmPassword: confirmPassword,
      address: '',
      birthDay: '',
      gender: 1,
    );
    if (isValidForm(request)) {
      ResponseApi responseApi = await webHookProvider.signUp(request);
      if (responseApi.status == "Success") {
        signInController.usernameController.text = username;
        signInController.passwordController.text = password;
        signInController.signIn();
        // UserData userData = UserData(
        //     uid: responseApi.account?.id,
        //     username: responseApi.account?.username,
        //     key: responseApi.key);
        // GetStorage().write('userData', userData.toJson());
        // gotoRootScreen();
      } else {
        Get.snackbar('Đăng ký thất bại', responseApi.message ?? '');
      }
    }
  }

  bool isValidForm(SignUpRequest request) {
    if (request.userName == null || request.userName!.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống tài khoản');
      return false;
    }
    if (request.firstName == null || request.firstName!.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống họ');
      return false;
    }
    if (request.lastName == null || request.lastName!.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống tên');
      return false;
    }
    if (request.phone == null || request.phone!.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống số điện thoại');
      return false;
    }
    if (request.email == null || request.email!.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống Email');
      return false;
    }
    if (request.password == null || request.password!.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống mật khẩu');
      return false;
    }
    if (request.confirmPassword == null || request.confirmPassword!.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống xác mật khẩu');
      return false;
    }
    if (request.password != request.confirmPassword) {
      Get.snackbar('Lưu ý', 'Mật khẩu không trùng với xác nhận mật khẩu');
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
