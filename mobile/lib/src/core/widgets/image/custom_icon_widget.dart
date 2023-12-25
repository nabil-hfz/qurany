// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:salon_app/core/utils/utils.dart';
//
// class CustomIconWidget extends StatelessWidget {
//   final double radius;
//   final String? svgIcon;
//   final IconData? icon;
//   final double size;
//   final Color? color;
//
//   const CustomIconWidget({
//     Key? key,
//     this.radius = 0.0,
//     this.size = 12.0,
//     this.color,
//     this.svgIcon,
//     this.icon,
//   })  : assert(svgIcon != null || icon != null,
//             'Both parameters [icon, svgIcon] cannot be null'),
//         super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(radius),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(radius),
//         ),
//         width: size,
//         height: size,
//         child: AppUtils.notNullOrEmpty(svgIcon)
//             ? SvgPicture.asset(
//                 svgIcon!,
//                 height: size,
//                 width: size,
//                 color: color,
//               )
//             : Icon(icon, color: color, size: size),
//       ),
//     );
//   }
// }
