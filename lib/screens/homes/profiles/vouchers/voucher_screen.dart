import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../models/voucher_response.dart';
import '../../../widgets/button_back_widget.dart';
import 'voucher_controller.dart';

class VoucherScreen extends StatelessWidget {
  VoucherScreen({super.key});

  final VoucherController voucherController = Get.put(VoucherController());

  @override
  Widget build(BuildContext context) {
    voucherController.getVoucher();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => SizedBox(
                        height: size.height * 0.9,
                        child: voucherController.voucherList.isNotEmpty
                            ? ListView.builder(
                                itemCount: voucherController.voucherList.length,
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
                                  child: Text("Không có dữ liệu"),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: size.width,
              color: Constants.primaryColor,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ButtonBackWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _voucher(int index, BuildContext context) {
    VoucherResponse voucher = voucherController.voucherList[index];
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
              child: Image.network(voucher.image ?? ''),
            ),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(voucher.name ?? ''),
                    Text('Code ${voucher.name ?? ''}'),
                    Text('Giảm: ${voucher.decreaseAmount ?? 0} VND'),
                    Text('HSD: ${voucher.endDate ?? ''}'),
                    Text('Chi tiết: ${voucher.description ?? ''}'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
