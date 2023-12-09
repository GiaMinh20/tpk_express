import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tpk_express/screens/homes/transportations/creates/create_transportation_screen.dart';
import 'package:tpk_express/screens/homes/transportations/statistics/statistic_transportation_screen.dart';

import '../../../constants/constants.dart';
import 'transportation_controller.dart';

class TransportationScreen extends StatelessWidget {
  TransportationScreen({super.key});

  final TransportationController transportationController =
      Get.put(TransportationController());
  final PageController pageController = PageController();

  List<Widget> _screenOptions() {
    return [
      CreateTransportationScreen(),
      StatisticTransportationScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          SizedBox(
              width: size.width,
              height: 50,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: transportationController.items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              transportationController.current.value =
                                  index;
                            },
                            child: Obx(
                              () => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.all(5),
                                width: 170,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: transportationController
                                              .current.value ==
                                          index
                                      ? Colors.white70
                                      : Colors.white54,
                                  borderRadius: transportationController
                                              .current.value ==
                                          index
                                      ? BorderRadius.circular(12)
                                      : BorderRadius.circular(7),
                                  border: transportationController
                                              .current.value ==
                                          index
                                      ? Border.all(
                                          color: Constants.primaryColor,
                                          width: 1)
                                      : null,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        transportationController.items[index],
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: transportationController
                                                      .current.value ==
                                                  index
                                              ? Colors.black
                                              : Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    );
                  })),
          Obx(() => IndexedStack(
                index: transportationController.current.value,
                children: _screenOptions(),
              )),
        ],
      ),
    );
  }
}
