import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpk_express/models/voucher_response.dart';

import '../../constants/constants.dart';
import '../homes/transportations/creates/create_transportation_controller.dart';
import 'vouchers_dialog.dart';

class CreateTransportationFormWidget extends StatelessWidget {
  CreateTransportationFormWidget(
      {super.key,
      this.function,
      this.barcodeController,
      this.noteController,
      required this.index,
      required this.id,
      required this.voucherResponse});

  final VoidCallback? function;
  final TextEditingController? barcodeController;
  final TextEditingController? noteController;
  final int index;
  final int id;
  Rx<VoucherResponse> voucherResponse;

  final CreateTransportationController createTransportationController =
      Get.put(CreateTransportationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Constants.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                    child: Text(
                  'Mã vận đơn:',
                  style: TextStyle(fontSize: 16),
                )),
                SizedBox(
                  width: size.width * 0.6,
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      labelText: '',
                    ),
                    controller: barcodeController,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                    child: Text(
                  'Thông tin:',
                  style: TextStyle(fontSize: 16),
                )),
                SizedBox(
                  width: size.width * 0.6,
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      labelText: '',
                    ),
                    controller: noteController,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: size.width,
            child: TextButton(
              onPressed: () async {
                await createTransportationController.getVoucher();
                showDialog(
                  builder: (context) => VouchersDialog(
                    formId: id,
                    selectedVoucher: voucherResponse.value,
                    vouchers: createTransportationController.listVoucher,
                  ),
                  context: context,
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(
                    () => Expanded(
                      flex: 1,
                      child: (voucherResponse.value.id ?? 0) > 0
                          ? Text(voucherResponse.value.name ?? '')
                          : Container(),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.payment,
                          color: Constants.primaryColor,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Chọn voucher',
                          style: TextStyle(color: Constants.primaryColor),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          index != 0
              ? ElevatedButton(
                  onPressed: function,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      disabledBackgroundColor: Colors.grey),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_circle_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Xóa',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
