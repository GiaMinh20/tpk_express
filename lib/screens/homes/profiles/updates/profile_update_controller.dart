import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tpk_express/models/request/account_info_request.dart';

import '../../../../models/account_info_response.dart';
import '../../../../models/response_api.dart';
import '../../../../models/warehouse_response.dart';
import '../../../../models/warehouse_shiptype_response.dart';
import '../../../../providers/webhook_provider.dart';
import '../profile_controller.dart';

class ProfileUpdateController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ImagePicker picker = ImagePicker();
  File? imageFile;

  List<Warehouse> fromWarehouses = <Warehouse>[].obs;
  var idFrom = ''.obs;
  List<Warehouse> vnWarehouses = <Warehouse>[].obs;
  var idVN = ''.obs;
  List<Warehouse> shipTypes = <Warehouse>[].obs;
  var idShip = '1'.obs;
  List<Warehouse> genders = <Warehouse>[].obs;
  var gender = ''.obs;

  var accountInfo = AccountInfoResponse().obs;

  RxBool isButtonEnabled = true.obs;

  final WebHookProvider webHookProvider = WebHookProvider();
  final ProfileController profileController = Get.put(ProfileController());

  ProfileUpdateController(){
    getWarehouseShipType();
  }
  Future<void> getAccountInfo() async {
    accountInfo.value =
        AccountInfoResponse.fromJson(GetStorage().read('accountInfo'));
    firstNameController.text = accountInfo.value.firstName!;
    lastnameController.text = accountInfo.value.lastName!;
    addressController.text = accountInfo.value.address!;
    gender.value = accountInfo.value.gender!.toString();
    idFrom.value = accountInfo.value.fromWarehouseId!.toString();
    idVN.value = accountInfo.value.toWarehouseId!.toString();
    idShip.value = accountInfo.value.shipType!.toString();
  }

  Future<void> getWarehouseShipType() async {
    WarehouseShipType warehouseShipType =
        await webHookProvider.getWarehouseShipType();
    if (warehouseShipType.fromWarehouses != null) {
      fromWarehouses.clear();
      fromWarehouses.addAll(warehouseShipType.fromWarehouses!);
    }
    if (warehouseShipType.vnWarehouses != null) {
      vnWarehouses.clear();
      vnWarehouses.addAll(warehouseShipType.vnWarehouses!);
    }
    if (warehouseShipType.shipTypes != null) {
      shipTypes.clear();
      shipTypes.addAll(warehouseShipType.shipTypes!);
    }
    genders.clear();
    genders
        .addAll([Warehouse(id: 1, name: 'Nam'), Warehouse(id: 2, name: 'Nữ')]);
  }

  Future<void> updateInfor(BuildContext context) async {
    String firstname = firstNameController.text.trim();
    String lastname = lastnameController.text.trim();
    String address = addressController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (isValidForm(firstname, lastname, address, password, confirmPassword)) {
      AccountInfoRequest request = AccountInfoRequest(
          firstName: firstname,
          lastName: lastname,
          gender: int.tryParse(gender.value) ?? 1,
          fromWarehouseId: int.tryParse(idFrom.value) ?? 1,
          toWarehouseId: int.tryParse(idVN.value) ?? 1,
          shipType: int.tryParse(idShip.value) ?? 1,
          address: address,
          password: password);
      String avatar = '';
      Completer<void> completer = Completer<void>();
      if (imageFile != null) {
        Stream stream = await webHookProvider.uploadImage(imageFile!);
        stream.listen((res) {
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          if (responseApi.status == 'Success') {
            avatar = responseApi.message!;
            completer.complete();
          } else {
            Get.snackbar('Thông báo', 'Lỗi tải hình ảnh');
            completer.completeError('Lỗi tải hình ảnh');
            return;
          }
        });
      } else {
        completer.complete();
      }
      await completer.future;
      request.avatar = avatar;
      ResponseApi responseApi =
          await webHookProvider.updateAccountInfo(request);
      if (responseApi.status == "Success") {
        Get.snackbar('Thông báo', 'Cập nhật thông tin thành công');
      } else {
        Get.snackbar('Thông báo', responseApi.message ?? '');
      }
    }
    profileController.getAccountInfo();
  }

  bool isValidForm(String name, String lastname, String address,
      String password, String confirmPassword) {
    if (name.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống họ');
      return false;
    }
    if (lastname.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống tên');
      return false;
    }
    if (address.isEmpty) {
      Get.snackbar('Lưu ý', 'Không để trống địa chỉ');
      return false;
    }
    if (password.isNotEmpty && (confirmPassword != password)) {
      Get.snackbar('Lưu ý', 'Xác nhận mật khẩu không trùng với mật khẩu');
      return false;
    }
    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: const Text(
          'Thư viện',
          style: TextStyle(color: Colors.black),
        ));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: const Text(
          'Camera',
          style: TextStyle(color: Colors.black),
        ));
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Chọn ảnh đại diện'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  Future<void> disableButton(BuildContext context) async {
    isButtonEnabled.value = false;

    await updateInfor(context);

    isButtonEnabled.value = true;
  }
}
