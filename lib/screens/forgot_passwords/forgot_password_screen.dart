import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../widgets/custom_textfield_widget.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);
  final ForgotPasswordController forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Image.asset(
                            'assets/images/logo-icon.png',
                            fit: BoxFit.contain,
                            height: size.height * 0.15,
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Nhận lại mật khẩu',
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          itemColor: Colors.white,
                          obscureText: false,
                          hintText: 'Địa chỉ Email',
                          icon: Icons.email,
                          controller: forgotPasswordController.emailController,
                          textInputType: TextInputType.emailAddress,
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
                                onPressed: forgotPasswordController
                                        .isButtonEnabled.value
                                    ? () {
                                        forgotPasswordController
                                            .disableButton();
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    backgroundColor: Constants.primaryColor,
                                    disabledBackgroundColor: Colors.grey),
                                child: Obx(() => Center(
                                      child: Text(
                                        forgotPasswordController
                                                .isButtonEnabled.value
                                            ? 'Gửi yêu cầu'
                                            : 'Đang gửi yêu cầu...',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    )),
                              ),
                            )),
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
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        SizedBox(
                          height: 50,
                          child: TextButton(
                            onPressed: () =>
                                forgotPasswordController.gotoSignInScreen(),
                            child: Center(
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                    text: 'Đã có tài khoản? ',
                                    style: TextStyle(
                                      color: Constants.blackColor,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'Đăng nhập ngay',
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
