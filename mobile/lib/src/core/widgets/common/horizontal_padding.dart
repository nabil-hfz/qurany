// Flutter imports:
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';

class HorizontalPadding extends StatelessWidget {
  final double percentage;

  const HorizontalPadding({super.key, this.percentage = .1})
      : assert(percentage >= 0 || percentage > 1);

  @override
  Widget build(BuildContext context) {
    double width = DeviceUtils.getScaledSize(context, percentage);
    return SizedBox(width: width);
  }
}

class HorizontalTextPadding extends StatelessWidget {
  final double width;

  const HorizontalTextPadding._({Key? key, required this.width})
      : super(key: key);

  factory HorizontalTextPadding.with1() {
    return const HorizontalTextPadding._(
      width: AppDimens.space1,
    );
  }

  factory HorizontalTextPadding.with2() {
    return const HorizontalTextPadding._(
      width: AppDimens.space2,
    );
  }

  factory HorizontalTextPadding.with4() {
    return const HorizontalTextPadding._(
      width: AppDimens.space4,
    );
  }

  factory HorizontalTextPadding.with6() {
    return const HorizontalTextPadding._(
      width: AppDimens.space6,
    );
  }

  factory HorizontalTextPadding.with8() {
    return const HorizontalTextPadding._(
      width: AppDimens.space8,
    );
  }

  factory HorizontalTextPadding.with10() {
    return const HorizontalTextPadding._(
      width: AppDimens.space10,
    );
  }

  factory HorizontalTextPadding.with12() {
    return const HorizontalTextPadding._(
      width: AppDimens.space12,
    );
  }

  factory HorizontalTextPadding.with14() {
    return const HorizontalTextPadding._(
      width: AppDimens.space14,
    );
  }

  factory HorizontalTextPadding.with16() {
    return const HorizontalTextPadding._(
      width: AppDimens.space16,
    );
  }

  factory HorizontalTextPadding.with20() {
    return const HorizontalTextPadding._(
      width: AppDimens.space20,
    );
  }

  factory HorizontalTextPadding.with24() {
    return const HorizontalTextPadding._(
      width: AppDimens.space24,
    );
  }

  factory HorizontalTextPadding.appBarAction() {
    return const HorizontalTextPadding._(
      width: AppDimens.space16,
    );
  }

  factory HorizontalTextPadding.appBarActionSmall() {
    return const HorizontalTextPadding._(
      width: AppDimens.space8,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
