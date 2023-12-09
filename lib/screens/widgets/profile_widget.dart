import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color? iconColor;

  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor ?? Colors.grey,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Constants.blackColor.withOpacity(.4),
            size: 16,
          )
        ],
      ),
    );
  }
}
