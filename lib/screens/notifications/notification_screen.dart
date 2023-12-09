import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tpk_express/screens/notifications/notification_controller.dart';

import '../../constants/constants.dart';
import '../../models/notification_response.dart';
import '../roots/root_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController notificationController =
      Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    notificationController.getNotification();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _buttonBack(context),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _notificationTypeRow(
                        context,
                        'Đơn hàng',
                        'Trạng thái đơn hàng của bạn',
                        Icons.fire_truck,
                        Constants.primaryColor,
                        10),
                    _notificationTypeRow(
                        context,
                        'Voucher',
                        'Bạn đã nhận được những voucher từ đâu?',
                        Icons.card_membership,
                        Colors.amber,
                        20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () =>
                                notificationController.gotoNotificationType(0),
                            child: Text(
                              'Xem tất cả',
                              style: TextStyle(
                                color: Constants.primaryColor,
                              ),
                            ))
                      ],
                    ),
                    Obx(
                      () => notificationController.notifications.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  notificationController.notifications.length,
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
          ],
        ),
      ),
    );
  }

  Widget _buttonBack(BuildContext context) {
    final RootController rootController = Get.put(RootController());
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: Constants.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SafeArea(
              child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {
                rootController.getTotalNotification();
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _notificationTypeRow(BuildContext context, String typeName,
      String typeSummary, IconData icon, Color iconColor, int type) {
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
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          Expanded(
            flex: 6,
            child: TextButton(
              onPressed: () =>
                  notificationController.gotoNotificationType(type),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          typeName,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          typeSummary,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _component(BuildContext context, int index) {
    NotificationResponse notificationResponse =
        notificationController.notifications[index];
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
