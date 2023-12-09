import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import 'root_controller.dart';

class RootScreen extends StatelessWidget {
  RootScreen({super.key});

  final RootController rootController = Get.put(RootController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: _rootAppBar(context),
          body: SafeArea(
            child: IndexedStack(
              index: rootController.bottomNavIndex.value,
              children: rootController.widgetOptions(),
            ),
          ),
          bottomNavigationBar: _bottomNavigationBar(context),
        ));
  }

  AppBar _rootAppBar(BuildContext context) {
    rootController.getTotalNotification();
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/logo-icon.png',
            fit: BoxFit.contain, // Đảm bảo hình ảnh không bị méo
            height: 40, // Thiết lập chiều cao tối đa cho hình ảnh
          ),
          GestureDetector(
            onTap: () => rootController.gotoNotification(),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: rootController.countNotification.value > 0
                  ? Stack(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: Constants.primaryColor,
                          size: 30,
                        ),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: Container(
                            width: 16,
                            height: 16,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                border: Border.all(
                                  width: 1,
                                  color: Constants.primaryColor,
                                )),
                            child: rootController.countNotification.value < 100
                                ? Text(
                                    '${rootController.countNotification.value}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.red),
                                  )
                                : Text(
                                    '99+',
                                    style: TextStyle(
                                        fontSize: 6,
                                        color: Constants.primaryColor),
                                  ),
                          ),
                        ),
                      ],
                    )
                  : Icon(
                      Icons.notifications,
                      color: Constants.primaryColor,
                      size: 30,
                    ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
    );
  }

  BottomNavigationBar _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Trang Chủ',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.fire_truck_sharp),
          label: 'Thêm Kiện',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          label: 'Tìm Kiếm',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Tài Khoản',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: 'Trò Chuyện',
        ),
      ],
      currentIndex: rootController.bottomNavIndex.value,
      selectedItemColor: Constants.primaryColor,
      onTap: (index) {
        if (index == 4) {
          rootController.openZalo(context);
        } else {
          rootController.bottomNavIndex.value = index;
        }
      },
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      showUnselectedLabels: true,
      elevation: 0,
      iconSize: 25,
      unselectedFontSize: 10,
      selectedFontSize: 10,
    );
  }
// AnimatedBottomNavigationBar _bottomNavigationBar(BuildContext context) {
//   return AnimatedBottomNavigationBar(
//     splashColor: Constants.primaryColor,
//     activeColor: Constants.primaryColor,
//     inactiveColor: Colors.black.withOpacity(0.5),
//     icons: rootController.iconList,
//     activeIndex: rootController.bottomNavIndex.value,
//     gapLocation: GapLocation.none,
//     notchSmoothness: NotchSmoothness.softEdge,
//     onTap: (index) {
//       if (index == 4) {
//         rootController.openZalo(context);
//       } else {
//         rootController.bottomNavIndex.value = index;
//       }
//     },
//   );
// }
}
