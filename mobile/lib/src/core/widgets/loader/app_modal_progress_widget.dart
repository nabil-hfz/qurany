// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:salon_app/core/constants/app_text_style.dart';
import 'package:salon_app/core/managers/theme/app_them_manager.dart';
import 'package:salon_app/core/widgets/common/vertical_padding.dart';

///
/// Wrap around any widget that makes an async call to show a modal progress
/// indicator while the async call is in progress.
///
/// HUD=Heads Up Display
///
class AppModalProgressHUDWidget extends StatelessWidget {
  /// A required [bool]to toggle the loading animation.
  final bool inAsyncCall;

  /// A [double] value which states how opaque the loading overlay should be, defaults to 0.3
  final double opacity;

  /// A [Color] object which is assigned to the loading barrier, defaults to grey
  final Color color;

  /// A [Widget] which is shown at the center of the modal loading barrier,
  /// defaults to the standard android spinny animation.
  final Widget progressIndicator;

  /// An [Offset] object which is applied to the [progressIndicator] when specified.
  final Offset? offset;

  /// A [bool] value which sets the `loading screen can be dismissible by tapping on the loading screen` rule.
  final bool dismissible;

  /// A [Widget] which should be the the widget to be shown behind the loading barrier.
  final Widget child;

  /// A [double] value specifying the amount of background blur of the progress.
  final double blur;

  final String? message;

  const AppModalProgressHUDWidget({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    required this.child,
    this.blur = 0.0,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;
    var appTheme = context.watch<AppThemeManager>();

    Widget layOutProgressIndicator;
    if (offset == null) {
      layOutProgressIndicator = Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          progressIndicator,
          if (message != null) VerticalTextPadding.with16(),
          if (message != null)
            Text(
              message!,
              style: appTextStyle.medium16.copyWith(
                color: appTheme.appColors.textColor,
              ),
            )
        ],
      ));
    } else {
      layOutProgressIndicator = Positioned(
        left: offset!.dx,
        top: offset!.dy,
        child: progressIndicator,
      );
    }

    return Stack(
      children: [
        child,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: dismissible, color: color),
          ),
        ),
        layOutProgressIndicator,
      ],
    );
  }
}
