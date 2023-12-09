import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../constants/constants.dart';
import '../widgets/custom_textfield_widget.dart';
import 'sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final SignInController signInController = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var isRegister = GetStorage().read('insurancePercent');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Image.asset(
                          'assets/images/logo-icon.png',
                          fit: BoxFit.contain,
                          height: size.height * 0.15,
                        ),
                      ),
                      CustomTextField(
                        itemColor: Colors.white,
                        obscureText: false,
                        hintText: 'Tài khoản',
                        icon: Icons.person,
                        controller: signInController.usernameController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        itemColor: Colors.white,
                        obscureText: true,
                        hintText: 'Mật khẩu',
                        icon: Icons.lock,
                        controller: signInController.passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Obx(
                          () => ElevatedButton(
                            onPressed: signInController.isButtonEnabled.value
                                ? () {
                                    signInController.disableButton();
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Constants.primaryColor,
                                disabledBackgroundColor:
                                    Constants.primaryColor),
                            child: Obx(() => Center(
                                  child: Text(
                                    signInController.isButtonEnabled.value
                                        ? 'Đăng nhập'
                                        : 'Đang đăng nhập...',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text('Hoặc'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isRegister == "1"
                          ? SizedBox(
                              height: 40,
                              child: TextButton(
                                onPressed: signInController.gotoSignUpScreen,
                                child: Center(
                                  child: Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: 'Chưa có tài khoản? ',
                                        style: TextStyle(
                                          color: Constants.blackColor,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'Đăng ký ngay',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextButton(
                          onPressed: () =>
                              signInController.gotoForgotPasswordScreen(),
                          child: Center(
                            child: Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                  text: 'Quên mật khẩu? ',
                                  style: TextStyle(
                                    color: Constants.blackColor,
                                  ),
                                ),
                                const TextSpan(
                                  text: 'Lấy lại mật khẩu',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
