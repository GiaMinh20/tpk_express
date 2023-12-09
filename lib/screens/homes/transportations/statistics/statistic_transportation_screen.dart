import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../models/statistics_response.dart';
import '../../../widgets/confirm_alert_dialog.dart';
import 'statistic_transportation_controller.dart';

class StatisticTransportationScreen extends StatelessWidget {
  StatisticTransportationScreen({super.key});

  final StatisticTransportationController statisticController =
      Get.put(StatisticTransportationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    statisticController.getStatistic();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:
                  size.height - (MediaQuery.of(context).padding.bottom + 190),
              child: Obx(
                () => statisticController.statistics.isNotEmpty
                    ? ListView.builder(
                        itemCount: statisticController.statistics.length,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _component(context, index);
                        },
                      )
                    : const Center(
                        child: Text("Không có dữ liệu"),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _component(BuildContext context, int index) {
    StatisticResponse statisticResponse = statisticController.statistics[index];
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Constants.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      width: size.width,
      child: Column(
        children: [
          ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            textColor: Colors.black54,
            iconColor: Colors.black54,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Id: ${statisticResponse.id}'),
                Text('Ngày YCXK : ${statisticResponse.dateRequest}'),
                Text('Trạng thái TT: ${statisticResponse.statusPaymentName}'),
                Text('Trạng thái XK : ${statisticResponse.statusExportName}'),
                statisticResponse.statusPayment != 2
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Thao tác: '),
                          TextButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => ConfirmAlertDialog(
                                alertText: 'Xác nhận thanh toán',
                                confirmFunction: () {
                                  statisticController.paymentStatistic(
                                      statisticResponse.id ?? 0);
                                },
                              ),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.payment,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Thanh toán',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [Text('Ngày xuất kho: ')],
                          ),
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                statisticResponse
                                    .statisticResponseElements!.length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      ),
                                      child: Text(
                                          'MVĐ: ${statisticResponse.statisticResponseElements![index].barcode}'),
                                    ),
                                    Text(statisticResponse
                                        .statisticResponseElements![index]
                                        .dateExport!),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text('Cân nặng: ${statisticResponse.weight} kg'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Số khối: ${statisticResponse.volume} m3'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Tổng tiền: ${statisticResponse.totalPriceVnd}'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Ghi chú: ${statisticResponse.staffNote}'),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
