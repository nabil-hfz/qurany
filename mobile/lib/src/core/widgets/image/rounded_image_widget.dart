// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:salon_app/core/constants/constants.dart';
//
// class RoundedAssetsImageWidget extends StatelessWidget {
//   final double radius;
//   final String pic;
//   final double picSize;
//   final Color? picSvgColor;
//
//   const RoundedAssetsImageWidget({
//     Key? key,
//     required this.radius,
//     required this.pic,
//     this.picSize = 20.0,
//     this.picSvgColor,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(shape: BoxShape.circle),
//       width: radius,
//       height: radius,
//       child: Center(
//         child: pic.toLowerCase().endsWith('.svg')
//             ? SvgPicture.asset(
//                 pic,
//                 height: picSize,
//                 width: picSize,
//                 color: picSvgColor,
//               )
//             : Image.asset(
//                 pic,
//                 height: picSize,
//                 width: picSize,
//               ),
//       ),
//     );
//   }
// }
