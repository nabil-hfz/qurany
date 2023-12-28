// Flutter imports:
// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/colors/app_colors.dart';
import 'package:kawtharuna/src/core/generated_files/assets/assets.gen.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/core/widgets/loader/app_loading_indicator.dart';

class ImageNetworkCircleWidget extends StatefulWidget {
  final String? imageUrl;
  final double? imageHeight;
  final double? imageWidth;
  final double? imageBorderRadius;
  final bool imageBorderRadiusTopLeft;
  final bool imageBorderRadiusTopRight;
  final bool imageBorderRadiusBottomLeft;
  final bool imageBorderRadiusBottomRight;
  final Color? imagePlaceHolderBackgroundColor;
  final bool isCache;
  final BoxFit? boxFit;
  final Widget? errorWidget;

  const ImageNetworkCircleWidget({
    Key? key,
    this.boxFit = BoxFit.cover,
    required this.imageUrl,
    this.imageHeight,
    this.errorWidget,
    this.imageWidth,
    this.isCache = false,
    this.imageBorderRadius = 0.0,
    this.imageBorderRadiusTopLeft = true,
    this.imageBorderRadiusTopRight = true,
    this.imageBorderRadiusBottomLeft = true,
    this.imageBorderRadiusBottomRight = true,
    this.imagePlaceHolderBackgroundColor,
  }) : super(key: key);

  @override
  _ImageNetworkCircleWidgetState createState() =>
      _ImageNetworkCircleWidgetState();
}

class _ImageNetworkCircleWidgetState extends State<ImageNetworkCircleWidget>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<ImageNetworkCircleWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            widget.imageBorderRadiusTopLeft ? widget.imageBorderRadius! : 0.0,
          ),
          topRight: Radius.circular(
            widget.imageBorderRadiusTopRight ? widget.imageBorderRadius! : 0.0,
          ),
          bottomLeft: Radius.circular(
            widget.imageBorderRadiusBottomLeft
                ? widget.imageBorderRadius!
                : 0.0,
          ),
          bottomRight: Radius.circular(
            widget.imageBorderRadiusBottomRight
                ? widget.imageBorderRadius!
                : 0.0,
          ),
        ),
        child: SizedBox(
            width: widget.imageWidth,
            height: widget.imageHeight,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl ?? "",
              // httpHeaders: optionsMedia,
              placeholder: (context, url) => placeholderWidget(),
              errorWidget: (context, url, error) => errorWidget(),
              height: widget.imageHeight,
              width: widget.imageWidth,
              fit: widget.boxFit,
            )));
  }

  Widget placeholderWidget() => Container(
        color: widget.imagePlaceHolderBackgroundColor,
        child: const AppLoader(),
      );

  Widget errorWidget() =>
      widget.errorWidget ??
      Container(
        color: AppColors.appPrimaryColor,
        child: AppImageWidget(
          path: Assets.images.imgLogo.path,
        ),
      );

  // Container(
  //   color: widget.imagePlaceHolderBackgroundColor,
  //   child: widget.errorWidget ??
  //       const Icon(
  //         Icons.broken_image_outlined,
  //         size: 35.0,
  //       ),
  // );

  @override
  bool get wantKeepAlive => true;
}
