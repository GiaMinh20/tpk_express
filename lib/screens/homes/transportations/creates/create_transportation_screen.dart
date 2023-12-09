import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../widgets/warehouse_shiptype_widget.dart';
import 'create_transportation_controller.dart';

class CreateTransportationScreen extends StatelessWidget {
  CreateTransportationScreen({super.key});

  final CreateTransportationController createTransportationController =
      Get.put(CreateTransportationController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
          reverse: true,
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height -
                      (MediaQuery.of(context).padding.bottom + 190),
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 56),
                    children: [
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                                child: Text(
                              'Kho gửi:',
                              style: TextStyle(fontSize: 16),
                            )),
                            SizedBox(
                              width: size.width * 0.7,
                              child: WarehouseDropDownWidget(
                                  warehouse: createTransportationController
                                      .fromWarehouses,
                                  hintText: 'Chọn kho gửi',
                                  value: createTransportationController
                                              .idFrom.value ==
                                          ''
                                      ? '1'
                                      : createTransportationController
                                          .idFrom.value,
                                  onChanged: (option) {
                                    createTransportationController
                                        .idFrom.value = option.toString();
                                  }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
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
                                  warehouse: createTransportationController
                                      .vnWarehouses,
                                  hintText: 'Chọn kho VN',
                                  value: createTransportationController
                                              .idVN.value ==
                                          ''
                                      ? '1'
                                      : createTransportationController
                                          .idVN.value,
                                  onChanged: (option) {
                                    createTransportationController.idVN.value =
                                        option.toString();
                                  }),
                            ),
                          ],
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // SizedBox(
                      //   width: size.width,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       const SizedBox(
                      //           child: Text(
                      //         'PTVC:',
                      //         style: TextStyle(fontSize: 16),
                      //       )),
                      //       SizedBox(
                      //         width: size.width * 0.7,
                      //         child: WarehouseDropDownWidget(
                      //             warehouse:
                      //                 createTransportationController.shipTypes,
                      //             hintText: 'Phương thức vận chuyển',
                      //             value: createTransportationController
                      //                         .idShip.value ==
                      //                     ''
                      //                 ? '1'
                      //                 : createTransportationController
                      //                     .idShip.value,
                      //             onChanged: (option) {
                      //               createTransportationController
                      //                   .idShip.value = option.toString();
                      //             }),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                                child: Text(
                              'Thông tin kiện:',
                              style: TextStyle(fontSize: 16),
                            )),
                            ElevatedButton(
                              onPressed: () =>
                                  createTransportationController.addForm(),
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  backgroundColor: Constants.primaryColor,
                                  disabledBackgroundColor:
                                      Constants.primaryColor),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.add),
                                  SizedBox(width: 8),
                                  Text(
                                    'Thêm kiện',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Obx(
                            () => Column(
                              children: List.generate(
                                  createTransportationController
                                      .inputForms.length,
                                  (index) => createTransportationController
                                      .inputForms[index]),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Obx(
                            () => ElevatedButton(
                              onPressed: createTransportationController
                                      .isButtonEnabled.value
                                  ? () {
                                      createTransportationController
                                          .disableButton();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  backgroundColor: Constants.primaryColor,
                                  disabledBackgroundColor:
                                      Constants.primaryColor),
                              child: Obx(() => Center(
                                    child: Text(
                                      createTransportationController
                                              .isButtonEnabled.value
                                          ? 'Tạo đơn'
                                          : 'Đang tạo đơn...',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  )),
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
