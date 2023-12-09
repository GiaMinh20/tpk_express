import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';

import '../../../constants/constants.dart';
import '../../../models/notification_response.dart';
import '../../widgets/button_back_widget.dart';
import 'notification_type_controller.dart';

class NotificationTypeListScreen extends StatelessWidget {
  NotificationTypeListScreen({super.key, required this.type});

  final NotificationTypeController notificationTypeController =
      Get.put(NotificationTypeController());
  final int type;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    notificationTypeController.getNotification(type);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => NumberPaginator(
                        numberPages: notificationTypeController.totalPage.value,
                        onPageChange: (int index) {
                          notificationTypeController.pageIndex.value = index;
                          notificationTypeController.getNotification(type);
                        },
                        initialPage: notificationTypeController.pageIndex.value,
                        config: NumberPaginatorUIConfig(
                          buttonSelectedForegroundColor: Colors.white,
                          buttonUnselectedForegroundColor:
                              Constants.primaryColor,
                          buttonUnselectedBackgroundColor: Colors.white,
                          buttonSelectedBackgroundColor: Constants.primaryColor,
                        ),
                      ),
                    ),
                    Obx(
                      () => notificationTypeController.notifications.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: notificationTypeController
                                  .notifications.length,
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

  Widget _component(BuildContext context, int index) {
    NotificationResponse notificationResponse =
        notificationTypeController.notifications[index];
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Màu của đường viền phía dưới
            width: 0.5, // Độ dày của đường viền phía dưới
          ),
        ),
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              flex: 1,
              child: Icon(
                Constants().getOrderIconFromInt(notificationResponse.message!),
                color: Colors.black54,
              )),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationResponse.title ?? 'Thông báo',
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  notificationResponse.message!,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  DateFormat('dd/MM/yy hh:mm')
                      .format(notificationResponse.createdDate!),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
