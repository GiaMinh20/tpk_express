import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpk_express/models/dashboard_response.dart';

import '../../../constants/constants.dart';
import 'dashboard_controller.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final DashBoardController dashboardController =
      Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: size.height - (MediaQuery.of(context).padding.bottom + 160),
            child: Obx(() => ListView.builder(
                  itemCount: dashboardController.dashboards.length,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _component(context, index);
                  },
                )),
          ),
        ],
      ),
    );
  }

  Widget _component(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    Dashboard dashboard = dashboardController.dashboards[index];
    return GestureDetector(
      onTap: () => dashboardController.gotoTransportationDetail(dashboard.id!),
      child: Container(
        decoration: BoxDecoration(
          color: Constants.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        width: size.width,
        child: Column(
          children: [
            _rowData('ID:', dashboard.id!.toString(), size),
            _rowData('Mã vận đơn:', dashboard.barCode!, size),
            _rowData('Trạng thái:', dashboard.status!, size),
            _rowData('Cân nặng:', '${dashboard.weight} kg', size),
            _rowData('Số khối:', '${dashboard.volume!} m3', size),
            _rowData('Ngày tạo:', dashboard.createdDate!, size)
          ],
        ),
      ),
    );
  }

  Widget _rowData(String title, String content, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(title),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            children: [
              Container(
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.55,
                  ),
                  child: Text(content)),
            ],
          )
        ],
      ),
    );
  }
}
