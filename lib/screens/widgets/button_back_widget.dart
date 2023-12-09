import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonBackWidget extends StatelessWidget {
  const ButtonBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
