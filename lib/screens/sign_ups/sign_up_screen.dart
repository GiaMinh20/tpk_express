import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../widgets/custom_textfield_widget.dart';
import 'sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final SignUpController signUpController = Get.put(SignUpController());

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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo-icon.png',
                      fit: BoxFit.contain,
                      height: size.height * 0.15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        inputBorder: InputBorder.none,
                        itemColor: Colors.white,
                        obscureText: false,
                        hintText: 'Tên đăng nhập',
                        icon: Icons.person,
                        controller: signUpController.usernameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        inputBorder: InputBorder.none,
                        itemColor: Colors.white,
                        obscureText: false,
                        hintText: 'Họ của bạn',
                        icon: Icons.abc,
                        controller: signUpController.firstNameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        inputBorder: InputBorder.none,
                        itemColor: Colors.white,
                        obscureText: false,
                        hintText: 'Tên của bạn',
                        icon: Icons.abc,
                        controller: signUpController.lastNameController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        inputBorder: InputBorder.none,
                        itemColor: Colors.white,
                        obscureText: false,
                        hintText: 'Địa chỉ Email',
                        icon: Icons.email,
                        textInputType: TextInputType.emailAddress,
                        controller: signUpController.emailController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        inputBorder: InputBorder.none,
                        itemColor: Colors.white,
                        obscureText: false,
                        hintText: 'Số điện thoại',
                        icon: Icons.phone,
                        textInputType: TextInputType.phone,
                        controller: signUpController.phoneController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        inputBorder: InputBorder.none,
                        itemColor: Colors.white,
                        obscureText: true,
                        hintText: 'Mật khẩu',
                        icon: Icons.lock,
                        controller: signUpController.passwordController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextField(
                        inputBorder: InputBorder.none,
                        itemColor: Colors.white,
                        obscureText: true,
                        hintText: 'Nhập lại khẩu',
                        icon: Icons.lock_outline,
                        controller: signUpController.confirmPasswordController,
                      ),
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
                            onPressed: signUpController.isButtonEnabled.value
                                ? () {
                                    signUpController.disableButton();
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                backgroundColor: Constants.primaryColor,
                                disabledBackgroundColor: Colors.grey),
                            child: Obx(() => Center(
                                  child: Text(
                                    signUpController.isButtonEnabled.value
                                        ? 'Đăng ký'
                                        : 'Đang đăng ký...',
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
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 40,
                      child: TextButton(
                        onPressed: signUpController.gotoSignInScreen,
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
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
