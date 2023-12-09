import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../widgets/profile_widget.dart';
import 'profile_controller.dart';
import 'updates/profile_update_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final ProfileController profileController = Get.put(ProfileController());
  final ProfileUpdateController profileUpdateController =
      Get.put(ProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Constants.primaryColor.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
                child: Obx(
                  () => profileController.accountInfo.value.avatar != '' &&
                          profileController.accountInfo.value.avatar != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              profileController.accountInfo.value.avatar!),
                        )
                      : const CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              ExactAssetImage('assets/images/profile.jpg'),
                        ),
                )),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${profileController.accountInfo.value.username}',
              style: TextStyle(
                color: Constants.blackColor,
                fontSize: 20,
              ),
            ),
            Text(
              'Ví TPK: ${profileController.accountInfo.value.wallet} VND',
              style: TextStyle(
                color: Constants.primaryColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Điện thoại: ${profileController.accountInfo.value.phone}',
              style: TextStyle(
                color: Constants.blackColor.withOpacity(.3),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Email: ${profileController.accountInfo.value.email}',
              style: TextStyle(
                color: Constants.blackColor.withOpacity(.3),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      profileController.gotoUpdateAccountInforScreen();
                      profileUpdateController.getAccountInfo();
                    },
                    child: const ProfileWidget(
                      icon: Icons.person,
                      title: 'Cập nhật tài khoản',
                      iconColor: Colors.green,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      profileController.gotoRechargeScreen();
                    },
                    child: const ProfileWidget(
                      icon: Icons.wallet,
                      title: 'Nạp tiền',
                      iconColor: Colors.orange,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      profileController.gotoVoucherScreen();
                    },
                    child: const ProfileWidget(
                      icon: Icons.payment,
                      title: 'Voucher',
                      iconColor: Colors.amber,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => profileController.openZalo(),
                    child: const ProfileWidget(
                      icon: Icons.chat,
                      title: 'Liên hệ Zalo',
                      iconColor: Colors.lightBlueAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => profileController.callHotline(),
                    child: const ProfileWidget(
                      icon: Icons.phone_forwarded,
                      title: 'Liên hệ hotline',
                      iconColor: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () => profileController.signOut(),
                    child: const ProfileWidget(
                      icon: Icons.logout,
                      title: 'Đăng xuất',
                      iconColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
