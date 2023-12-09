import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpk_express/models/recharge_response.dart';

import '../../../../constants/constants.dart';
import '../../../widgets/button_back_widget.dart';
import '../../../widgets/confirm_alert_dialog.dart';
import '../../../widgets/warehouse_shiptype_widget.dart';
import 'recharge_controller.dart';

class RechargeScreen extends StatelessWidget {
  RechargeScreen({super.key});

  final RechargeController rechargeController = Get.put(RechargeController());

  @override
  Widget build(BuildContext context) {
    rechargeController.getRecharges();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, bottom: 20, left: 10, right: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: Text(
                          'Nạp tiền',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    _rechargedInfo(),
                    _rechargeForm(context),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    _rechargedList(size),
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

  Widget _rechargedList(Size size) {
    return Obx(
      () => SizedBox(
        height: rechargeController.rechargeList.isNotEmpty
            ? size.height * 0.5
            : size.height * 0.2,
        child: SingleChildScrollView(
          child: rechargeController.rechargeList.isNotEmpty
              ? ListView.builder(
                  itemCount: rechargeController.rechargeList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _rechargeRequest(index, context);
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
    );
  }

  Widget _rechargedInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => RichText(
            text: TextSpan(
              text: 'Tổng tiền đã nạp: ',
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: rechargeController.rechargeList.isNotEmpty
                      ? (rechargeController.rechargeList[0].amountRecharged ??
                          '0')
                      : '0',
                  style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' VND',
                  style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
          () => RichText(
            text: TextSpan(
              text: 'Số dư hiện tại: ',
              style: const TextStyle(color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: rechargeController.rechargeList.isNotEmpty
                      ? (rechargeController.rechargeList[0].currentWallet ??
                          '0')
                      : '0',
                  style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: ' VND',
                  style: TextStyle(
                      color: Constants.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _rechargeForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Ngân hàng',
                  style: TextStyle(
                      fontSize: 16, color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Expanded(
                flex: 5,
                child: Obx(
                  () => WarehouseDropDownWidget(
                    warehouse: rechargeController.banks,
                    hintText: 'Tài khoản',
                    value: rechargeController.bankId.value == ''
                        ? '1'
                        : rechargeController.bankId.value,
                    onChanged: (option) {
                      rechargeController.bankId.value = option.toString();
                    },
                  ),
                ),
              ),
            ],
          ),
          TextField(
            controller: rechargeController.amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Số tiền',
              suffixIcon: Icon(Icons.money),
            ),
          ),
          TextField(
            controller: rechargeController.contentController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Nội dung (TPK Username)',
              suffixIcon: Icon(Icons.text_increase),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: rechargeController.isButtonEnabled.value
                  ? () {
                      rechargeController.disableButton(context);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                backgroundColor: Constants.primaryColor,
              ),
              child: Obx(
                () => Text(
                  rechargeController.isButtonEnabled.value
                      ? 'Gửi yêu cầu'
                      : 'Đang gửi...',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rechargeRequest(int index, BuildContext context) {
    RechargeResponse rechargeResponse = rechargeController.rechargeList[index];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Constants.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 1,
                child: Text('Ngày nạp: '),
              ),
              Expanded(
                flex: 1,
                child: Text(rechargeResponse.createdDate ?? ''),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 1,
                child: Text('Số tiền: '),
              ),
              Expanded(
                flex: 1,
                child: Text('${rechargeResponse.amount} VND'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 1,
                child: Text('Nội dung: '),
              ),
              Expanded(
                flex: 1,
                child: Text(rechargeResponse.tradeContent ?? ''),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                flex: 1,
                child: Text('Trạng thái: '),
              ),
              Expanded(
                flex: 1,
                child: Text(rechargeResponse.statusName ?? 'Không xác định'),
              ),
            ],
          ),
          rechargeResponse.status == 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: Text('Hủy yêu cầu: '),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => ConfirmAlertDialog(
                            alertText: 'Xác nhận hủy lệnh nạp',
                            confirmFunction: () {
                              rechargeController
                                  .cancelRecharge(rechargeResponse.id ?? 0);
                            },
                          ),
                        ),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
