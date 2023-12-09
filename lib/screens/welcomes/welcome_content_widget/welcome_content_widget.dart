import 'package:flutter/material.dart';

class WelcomeContentWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const WelcomeContentWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          image,
          fit: BoxFit.contain, // Đảm bảo hình ảnh trải đều trên chiều rộng
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Container(
//     padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.3,
//           child: Image.asset(image),
//         ),
//         // const SizedBox(
//         //   height: 20,
//         // ),
//         // Text(
//         //   title,
//         //   textAlign: TextAlign.center,
//         //   style: TextStyle(
//         //       color: Constants.primaryColor,
//         //       fontSize: 30,
//         //       fontWeight: FontWeight.bold),
//         // ),
//         // const SizedBox(
//         //   height: 20,
//         // ),
//         // Text(
//         //   description,
//         //   textAlign: TextAlign.center,
//         //   style: const TextStyle(
//         //       fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey),
//         // )
//       ],
//     ),
//   );
// }
}
