import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import 'welcome_content_widget/welcome_content_widget.dart';
import 'welcome_controller.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final WelcomeController welcomeController = Get.put(WelcomeController());
  final PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (currentIndex == 0) {
      welcomeController.checkFirstTimeOpened();
    }
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            PageView(
              onPageChanged: (int page) {
                setState(() {
                  currentIndex = page;
                });
              },
              controller: pageController,
              children: [
                WelcomeContentWidget(
                  image: 'assets/images/banner-one.png',
                  title: Constants.titleOne,
                  description: Constants.descriptionOne,
                ),
                WelcomeContentWidget(
                  image: 'assets/images/banner-two.png',
                  title: Constants.titleTwo,
                  description: Constants.descriptionTwo,
                ),
                WelcomeContentWidget(
                  image: 'assets/images/banner-three.png',
                  title: Constants.titleThree,
                  description: Constants.descriptionThree,
                ),
              ],
            ),
            Positioned(
              bottom: 25,
              left: 30,
              child: Row(
                children: _buildIndicator(),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 30,
              child: Container(
                height: 45,
                width: 45,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Constants.primaryColor),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (currentIndex < 2) {
                        currentIndex++;
                        if (currentIndex < 3) {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      } else {
                        welcomeController.gotoSignInScreen();
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.primaryColor,
                        elevation: 0,
                      ),
                      onPressed: welcomeController.gotoSignInScreen,
                      child: const Text(
                        'Bỏ qua',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(5)),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
