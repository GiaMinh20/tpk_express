import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/voucher_response.dart';
import '../homes/transportations/creates/create_transportation_controller.dart';

class VouchersDialog extends StatelessWidget {
  VouchersDialog(
      {super.key,
      this.vouchers,
      required this.selectedVoucher,
      required this.formId});

  final List<VoucherResponse>? vouchers;
  final VoucherResponse selectedVoucher;
  final int formId;

  final CreateTransportationController createTransportationController =
      Get.put(CreateTransportationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if ((selectedVoucher.id ?? 0) > 0) {
      vouchers!.insert(0, selectedVoucher);
    }
    return AlertDialog(
      title: const Center(child: Text('Danh sách voucher')),
      contentPadding: const EdgeInsets.all(5),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.5,
              width: size.width,
              child: vouchers!.isNotEmpty
                  ? ListView.builder(
                      itemCount: vouchers!.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _voucher(index, context);
                      },
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Center(
                        child: Text("Không có voucher"),
                      ),
                    ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Tắt AlertDialog khi nút được bấm
          },
          child: const Text('Đóng'),
        ),
      ],
    );
  }

  Widget _voucher(int index, BuildContext context) {
    var voucher = vouchers![index];
    bool isChecked = selectedVoucher.id == voucher.id ? true : false;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.network(voucher.image!),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(voucher.name ?? ''),
                    Text('HSD: ${voucher.endDate ?? ''}'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Checkbox(
                onChanged: (value) {
                  createTransportationController.addVoucher(
                      formId, voucher.id!, isChecked);
                  Navigator.pop(context);
                },
                value: isChecked,
              ),
            )
          ],
        ),
      ),
    );
  }
}
