import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpk_express/constants/constants.dart';

import '../../../widgets/warehouse_shiptype_widget.dart';
import 'profile_update_controller.dart';

class ProfileUpdateScreen extends StatelessWidget {
  ProfileUpdateScreen({super.key});

  final ProfileUpdateController profileUpdateController =
      Get.put(ProfileUpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          _buttonBack(),
        ]),
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.only(left: 20),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 30,
        ),
      ),
    ));
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      color: Constants.primaryColor,
    );
  }

  Widget _boxForm(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      margin: EdgeInsets.only(top: size.height * 0.3),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54, blurRadius: 15, offset: Offset(0, 0.75))
          ]),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(children: [
            _textFieldName(),
            _textFieldLastName(),
            _textFieldAddress(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(
                () => Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              child: Text(
                            'Giới tính:',
                            style: TextStyle(fontSize: 16),
                          )),
                          SizedBox(
                            width: size.width * 0.7,
                            child: WarehouseDropDownWidget(
                                warehouse: profileUpdateController.genders,
                                hintText: 'Chọn giới tính',
                                value:
                                    profileUpdateController.gender.value == ''
                                        ? '1'
                                        : profileUpdateController.gender.value,
                                onChanged: (option) {
                                  profileUpdateController.gender.value =
                                      option.toString();
                                }),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              child: Text(
                            'Kho gửi:',
                            style: TextStyle(fontSize: 16),
                          )),
                          SizedBox(
                            width: size.width * 0.7,
                            child: WarehouseDropDownWidget(
                                warehouse:
                                    profileUpdateController.fromWarehouses,
                                hintText: 'Chọn kho gửi',
                                value:
                                    profileUpdateController.idFrom.value == ''
                                        ? '1'
                                        : profileUpdateController.idFrom.value,
                                onChanged: (option) {
                                  profileUpdateController.idFrom.value =
                                      option.toString();
                                }),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              child: Text(
                            'Kho VN:',
                            style: TextStyle(fontSize: 16),
                          )),
                          SizedBox(
                            width: size.width * 0.7,
                            child: WarehouseDropDownWidget(
                                warehouse: profileUpdateController.vnWarehouses,
                                hintText: 'Chọn kho VN',
                                value: profileUpdateController.idVN.value == ''
                                    ? '1'
                                    : profileUpdateController.idVN.value,
                                onChanged: (option) {
                                  profileUpdateController.idVN.value =
                                      option.toString();
                                }),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // SizedBox(
                    //   width: size.width * 0.9,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const SizedBox(
                    //           child: Text(
                    //         'PTVC:',
                    //         style: TextStyle(fontSize: 16),
                    //       )),
                    //       SizedBox(
                    //         width: size.width * 0.7,
                    //         child: WarehouseDropDownWidget(
                    //             warehouse: profileUpdateController.shipTypes,
                    //             hintText: 'Phương thức vận chuyển',
                    //             value:
                    //                 profileUpdateController.idShip.value == ''
                    //                     ? '1'
                    //                     : profileUpdateController.idShip.value,
                    //             onChanged: (option) {
                    //               profileUpdateController.idShip.value =
                    //                   option.toString();
                    //             }),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            _textFieldPassword(),
            _textFieldConfirmPassword(),
            const SizedBox(
              height: 20,
            ),
            _buttonUpdate(context),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return TextField(
      controller: profileUpdateController.firstNameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          labelText: 'Họ', prefixIcon: Icon(Icons.person)),
    );
  }

  Widget _textFieldLastName() {
    return TextField(
      controller: profileUpdateController.lastnameController,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
          labelText: 'Tên', prefixIcon: Icon(Icons.person_outline)),
    );
  }

  Widget _textFieldAddress() {
    return TextField(
      controller: profileUpdateController.addressController,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.map_outlined), labelText: 'Địa chỉ'),
    );
  }

  Widget _textFieldPassword() {
    return TextField(
      controller: profileUpdateController.passwordController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        labelText: 'Mật khẩu',
      ),
      obscureText: true,
    );
  }

  Widget _textFieldConfirmPassword() {
    return TextField(
      controller: profileUpdateController.confirmPasswordController,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock_outline), labelText: 'Xác nhận mật khẩu'),
      obscureText: true,
    );
  }

  Widget _buttonUpdate(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => ElevatedButton(
          onPressed: profileUpdateController.isButtonEnabled.value
              ? () {
                  profileUpdateController.disableButton(context);
                }
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            backgroundColor: Constants.primaryColor,
          ),
          child: Obx(
            () => Text(
              profileUpdateController.isButtonEnabled.value
                  ? 'Cập nhật'
                  : 'Đang cập nhật...',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(top: 25),
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () => profileUpdateController.showAlertDialog(context),
            child: GetBuilder<ProfileUpdateController>(
              builder: (value) => CircleAvatar(
                backgroundImage: profileUpdateController.imageFile != null
                    ? FileImage(profileUpdateController.imageFile!)
                    : profileUpdateController.accountInfo.value.avatar !=
                                null &&
                            profileUpdateController.accountInfo.value.avatar !=
                                ''
                        ? NetworkImage(
                            profileUpdateController.accountInfo.value.avatar!)
                        : const AssetImage('assets/images/profile.jpg')
                            as ImageProvider,
                radius: 60,
                backgroundColor: Colors.white,
              ),
            ),
          )),
    );
  }
}
