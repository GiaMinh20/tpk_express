import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../models/transportation_response.dart';
import '../../../roots/root_controller.dart';
import '../../../widgets/cancel_alert_dialog.dart';
import '../../../widgets/filter_order_dialog.dart';
import '../../trackings/tracking_controller.dart';
import 'list_transportation_controller.dart';

class ListTransportationScreen extends StatelessWidget {
  ListTransportationScreen({super.key});

  final ListTransportationController listTransportationController =
      Get.put(ListTransportationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    listTransportationController.getListTransportation(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _status(size, listTransportationController.statusName),
          Obx(
            () => SizedBox(
              height: 40,
              child: Pagination(
                paginateButtonStyles: PaginateButtonStyles(
                  activeBackgroundColor: Colors.transparent,
                  activeTextStyle: TextStyle(color: Constants.primaryColor),
                  backgroundColor: Colors.transparent,
                  textStyle: TextStyle(
                    color: Constants.blackColor,
                  ),
                  fontSize: 13,
                ),
                prevButtonStyles: PaginateSkipButton(
                  buttonBackgroundColor: Colors.transparent,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Constants.primaryColor,
                    size: 20,
                  ),
                ),
                nextButtonStyles: PaginateSkipButton(
                  buttonBackgroundColor: Colors.transparent,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Constants.primaryColor,
                    size: 20,
                  ),
                ),
                totalPage: listTransportationController.totalPage.value,
                onPageChange: (int index) {
                  listTransportationController.pageIndex.value = index - 1;
                  listTransportationController.getListTransportation(
                      listTransportationController.isFilter.value);
                },
                show: listTransportationController.totalPage.value <= 6
                    ? (listTransportationController.totalPage.value - 1)
                    : 6,
                currentPage: (listTransportationController.pageIndex.value + 1),
                useGroup: true,
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => listTransportationController.transportations.isNotEmpty
                  ? ListView.builder(
                      itemCount:
                          listTransportationController.transportations.length,
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
    );
  }

  Widget _status(Size size, List<String> status) {
    return SizedBox(
      height: Platform.isAndroid ? 60 : 70,
      width: size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: status.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                if (index == 7) {
                  showDialog(
                    context: context,
                    builder: (context) => FilterOrderDialog(
                      filterFunction: () => listTransportationController
                          .getListTransportation(true),
                      searchContentController:
                          listTransportationController.filterContentController,
                      selectedValue: listTransportationController.type,
                      fromDate: listTransportationController.fromDate,
                      toDate: listTransportationController.toDate,
                      cancelFilterFunction: () =>
                          listTransportationController.cancelFilter(),
                    ),
                  );
                } else {
                  listTransportationController.setStatusByIndex(index);
                }
              },
              child: Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Icon(
                          listTransportationController.iconStatus[index],
                          size: 25,
                          color: (index != 7)
                              ? Constants.primaryColor
                              : Constants.blackColor,
                        ),
                        Text(
                          status[index],
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: (listTransportationController
                                              .currentIndex.value ==
                                          index &&
                                      index != 7)
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: (listTransportationController
                                              .currentIndex.value ==
                                          index &&
                                      index != 7)
                                  ? Constants.primaryColor
                                  : Colors.black),
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget _component(BuildContext context, int index) {
    final RootController rootController = Get.put(RootController());
    final TrackingController trackingController = Get.put(TrackingController());

    TransportationResponse transportationResponse =
        listTransportationController.transportations[index];
    Size size = MediaQuery.of(context).size;
    Constants constants = Constants();
    return Container(
      decoration: BoxDecoration(
        color: constants
            .getColorFromInt(transportationResponse.status!)
            .withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      width: size.width,
      child: Column(
        children: [
          ExpansionTile(
            expandedAlignment: Alignment.centerLeft,
            textColor: Colors.black,
            iconColor: Colors.black54,
            tilePadding: const EdgeInsets.all(0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    ((index + 1) +
                            (listTransportationController.pageIndex.value * 10))
                        .toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 15,
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mã vận đơn: ${transportationResponse.barcode}',
                        style: const TextStyle(color: Colors.black),
                      ),
                      Text('Trạng thái: ${transportationResponse.statusName}',
                          style: const TextStyle(color: Colors.black)),
                      Text('Thông tin: ${transportationResponse.note}',
                          style: const TextStyle(color: Colors.black))
                    ],
                  ),
                ),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text('ID: ${transportationResponse.id}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))),
                        Expanded(
                            flex: 1,
                            child: Text(
                                'Số kiện: ${transportationResponse.quantity}',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                              'Cân nặng: ${transportationResponse.weight} kg',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              'Số khối: ${transportationResponse.volume} m3',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                              'Kho TQ: ${transportationResponse.fromWarehouse}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              'Kho VN: ${transportationResponse.vnWarehouse}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                              'PTVC: ${transportationResponse.shippingType}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              'Cước vật tư: ${transportationResponse.sensorFeeeVnd} VND',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                              'Ngày tạo: ${transportationResponse.createdDate}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              'Ngày XK: ${transportationResponse.dateExport}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('Ghi chú: ${transportationResponse.exportRequestNote}',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Thao tác: '),
                        const SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              trackingController.onChangeText(
                                  transportationResponse.barcode ?? '');
                              rootController.bottomNavIndex.value = 2;
                            },
                            icon: const Icon(Icons.remove_red_eye)),
                        const SizedBox(
                          width: 20,
                        ),
                        transportationResponse.status == 1
                            ? IconButton(
                                onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => CancelAlertDialog(
                                        cancelFunction: () =>
                                            listTransportationController
                                                .cancelOrder(
                                                    transportationResponse.id ??
                                                        0),
                                        cancelReasonController:
                                            listTransportationController
                                                .cancelReasonController,
                                      ),
                                    ),
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
