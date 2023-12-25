// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:salon_app/core/constants/app_dimens.dart';
// import 'package:salon_app/core/constants/colors/app_colors.dart';
// import 'package:salon_app/core/managers/localization/app_translation.dart';
// import 'package:salon_app/core/utils/utils.dart';
// import 'package:salon_app/core/widgets/button/app_inkwell_widget.dart';
// import 'package:salon_app/core/widgets/common/salony_app_bar.dart';
//
// import 'app_image_widget.dart';
//
// class GalleryFullViewWidget extends StatefulWidget {
//   final ImageGalleryArgs args;
//
//   const GalleryFullViewWidget({Key? key, required this.args}) : super(key: key);
//
//   @override
//   State<GalleryFullViewWidget> createState() => _GalleryFullViewWidgetState();
// }
//
// class _GalleryFullViewWidgetState extends State<GalleryFullViewWidget> {
//   CarouselController buttonCarouselController = CarouselController();
//   CarouselController buttonCarouselController2 = CarouselController();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // buttonCarouselController.animateToPage(widget.args.index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = DeviceUtils.getScaledHeight(context, 1.0);
//     return Scaffold(
//       appBar: SalonyAppBar(
//           title: "${widget.args.salonName} ${translate.gallery}",
//           titleColor: AppColors.white,
//           backgroundColor: AppColors.black.withOpacity(0.7),
//           arrowBackColor: AppColors.white,
//           systemOverlayStyle:
//               const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark)),
//       backgroundColor: AppColors.black.withOpacity(0.7),
//       body: SizedBox(
//         height: height,
//         child: Stack(
//           children: [
//             CarouselSlider(
//               carouselController: buttonCarouselController,
//               options: CarouselOptions(
//                   height: height,
//                   initialPage: widget.args.index,
//                   aspectRatio: 1.0,
//                   viewportFraction: 1.0,
//                   enlargeCenterPage: false,
//                   onPageChanged: (index, reason) {
//                     buttonCarouselController.animateToPage(index,
//                         duration: const Duration(milliseconds: 333),
//                         curve: Curves.linear);
//
//                     buttonCarouselController2.animateToPage(index,
//                         duration: const Duration(milliseconds: 333),
//                         curve: Curves.linear);
//                   }),
//               items: widget.args.images
//                   .map(
//                     (image) => SizedBox(
//                       height: height,
//                       child: Center(
//                         child: Hero(
//                           tag: image,
//                           child: AppImageWidget(
//                             path: image,
//                             width: double.infinity,
//                             height: height,
//                             boxFit: BoxFit.fill,
//                             // radius: double.infinity,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                   .toList(),
//             ),
//             Align(
//               alignment: AlignmentDirectional.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: AppDimens.space32),
//                 child: CarouselSlider(
//                   carouselController: buttonCarouselController2,
//                   options: CarouselOptions(
//                     height: height * .1,
//                     enlargeFactor: 0.1,
//                     initialPage: widget.args.index,
//                     aspectRatio: 2.0,
//                     viewportFraction: .21,
//                     enlargeCenterPage: true,
//                     enlargeStrategy: CenterPageEnlargeStrategy.zoom,
//                   ),
//                   items: widget.args.images
//                       .map(
//                         (image) => AppInkWellWidget(
//                           onTap: () {
//                             buttonCarouselController.jumpToPage(
//                               widget.args.images.indexOf(image),
//                               // duration: const Duration(milliseconds: 333),
//                               // curve: Curves.linear
//                             );
//                           },
//                           child: Container(
//                             height: height,
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: AppDimens.space4),
//                             child: Center(
//                               child: AppImageWidget(
//                                 path: image,
//                                 width: double.infinity,
//                                 height: height * .1,
//                                 boxFit: BoxFit.fill,
//                                 // radius: double.infinity,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ImageGalleryArgs {
//   final int index;
//   final List<String> images;
//   final String salonName;
//
//   const ImageGalleryArgs(
//       {required this.images, required this.salonName, required this.index});
// }
