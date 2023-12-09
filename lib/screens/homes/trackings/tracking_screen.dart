import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tpk_express/constants/constants.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../widgets/warehouse_shiptype_widget.dart';
import 'tracking_controller.dart';

class TrackingScreen extends StatelessWidget {
  TrackingScreen({super.key});

  final TrackingController trackingController = Get.put(TrackingController());

  @override
  Widget build(BuildContext context) {
    Constants constants = Constants();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _textFieldSearch(context),
              Obx(
                () => trackingController.trackingResponse.value.id != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            afterLineStyle: LineStyle(
                                color: constants.getColorTracking(
                                    trackingController.afterColors[0])),
                            isFirst: true,
                            isLast: false,
                            indicatorStyle: IndicatorStyle(
                              width: 50,
                              color: constants.getColorTracking(
                                  trackingController.iconColors[0]),
                              iconStyle: IconStyle(
                                color: Colors.white,
                                iconData: Icons.warehouse,
                              ),
                            ),
                            endChild: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              constraints: const BoxConstraints(minWidth: 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Đã về kho TQ'),
                                  Text(trackingController
                                          .trackingResponse.value.dateTq ??
                                      '')
                                ],
                              ),
                            ),
                          ),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            afterLineStyle: LineStyle(
                                color: constants.getColorTracking(
                                    trackingController.afterColors[1])),
                            beforeLineStyle: LineStyle(
                                color: constants.getColorTracking(
                                    trackingController.beforeColors[1])),
                            isFirst: false,
                            isLast: false,
                            indicatorStyle: IndicatorStyle(
                              width: 50,
                              color: constants.getColorTracking(
                                  trackingController.iconColors[1]),
                              iconStyle: IconStyle(
                                color: Colors.white,
                                iconData: Icons.local_shipping_rounded,
                              ),
                            ),
                            endChild: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              constraints: const BoxConstraints(minWidth: 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Đang về kho VN'),
                                  Text(trackingController.trackingResponse.value
                                          .dateComingVn ??
                                      '')
                                ],
                              ),
                            ),
                          ),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            afterLineStyle: LineStyle(
                                color: constants.getColorTracking(
                                    trackingController.afterColors[2])),
                            beforeLineStyle: LineStyle(
                                color: constants.getColorTracking(
                                    trackingController.beforeColors[2])),
                            isFirst: false,
                            isLast: false,
                            indicatorStyle: IndicatorStyle(
                              width: 50,
                              color: constants.getColorTracking(
                                  trackingController.iconColors[2]),
                              iconStyle: IconStyle(
                                color: Colors.white,
                                iconData: Icons.task_rounded,
                              ),
                            ),
                            endChild: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              constraints: const BoxConstraints(minWidth: 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Kiểm hóa'),
                                  Text(trackingController
                                          .trackingResponse.value.dateCheck ??
                                      '')
                                ],
                              ),
                            ),
                          ),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            afterLineStyle: LineStyle(
                                color: constants.getColorTracking(
                                    trackingController.afterColors[3])),
                            beforeLineStyle: LineStyle(
                                color: constants.getColorTracking(
                                    trackingController.beforeColors[3])),
                            isFirst: false,
                            isLast: false,
                            indicatorStyle: IndicatorStyle(
                              width: 50,
                              color: constants.getColorTracking(
                                  trackingController.iconColors[3]),
                              iconStyle: IconStyle(
                                color: Colors.white,
                                iconData: Icons.warehouse,
                              ),
                            ),
                            endChild: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              constraints: const BoxConstraints(minWidth: 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Đã về kho VN'),
                                  Text(trackingController
                                          .trackingResponse.value.dateVn ??
                                      '')
                                ],
                              ),
                            ),
                          ),
                          TimelineTile(
                            alignment: TimelineAlign.manual,
                            lineXY: 0.1,
                            beforeLineStyle: LineStyle(
                                color: constants.getColorTracking(
                                    trackingController.beforeColors[4])),
                            isFirst: false,
                            isLast: true,
                            indicatorStyle: IndicatorStyle(
                              width: 50,
                              color: constants.getColorTracking(
                                  trackingController.iconColors[4]),
                              iconStyle: IconStyle(
                                color: Colors.white,
                                iconData: Icons.thumb_up_alt,
                              ),
                            ),
                            endChild: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              constraints: const BoxConstraints(minWidth: 100),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Đã xuất kho'),
                                  Text(trackingController
                                          .trackingResponse.value.dateExport ??
                                      '')
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  const Center(
                    child: Text(
                      'Tính cước vận chuyển',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Obx(
                    () => SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                              child: Text(
                            'Kho VN:',
                            style: TextStyle(fontSize: 16),
                          )),
                          SizedBox(
                            width: size.width * 0.7,
                            child: WarehouseDropDownWidget(
                                warehouse: trackingController.vnWarehouses,
                                hintText: 'Chọn kho VN',
                                value: trackingController.idVN.value == ''
                                    ? '1'
                                    : trackingController.idVN.value,
                                onChanged: (option) {
                                  trackingController.idVN.value =
                                      option.toString();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Tên hàng',
                      ),
                      controller: trackingController.productNameController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Tổng tiền + ship nội địa TQ (Tệ)',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: trackingController.totalShipController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Cân nặng (Kg)',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: trackingController.weightController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Số khối (m3)',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: trackingController.volumeController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Số lượng (chiếc)',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: false),
                      controller: trackingController.numberController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Ship nội địa VN (nếu có)',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: false),
                      controller: trackingController.shipInVNController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Ghi chú',
                      ),
                      keyboardType: TextInputType.text,
                      controller: trackingController.noteController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Đơn giá (Tệ)',
                      ),
                      readOnly: true,
                      controller: trackingController.unitPriceController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Đơn giá về tay (VNĐ)',
                      ),
                      readOnly: true,
                      controller: trackingController.totalPriceController,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Phí ship quốc tế theo KG',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: trackingController.shipVNController,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        labelText: 'Phí ship quốc tế theo Khối',
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      controller: trackingController.shipVNVolumeController,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () => trackingController.tracking(
                          trackingController.barcodeController.text, 1),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Constants.primaryColor,
                          disabledBackgroundColor: Constants.primaryColor),
                      child: const Center(
                        child: Text(
                          'Tính cước',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: trackingController.barcodeController,
        onChanged: trackingController.onChangeText,
        decoration: InputDecoration(
            hintText: 'Mã vận đơn',
            suffixIcon: Icon(
              Icons.search,
              color: Constants.primaryColor,
            ),
            fillColor: Colors.white,
            filled: true,
            hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Constants.primaryColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Constants.primaryColor)),
            contentPadding: const EdgeInsets.all(10)),
      ),
    );
  }
}
