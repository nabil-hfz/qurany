// Flutter imports:
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';

class VerticalPadding extends StatelessWidget {
  final double percentage;

  const VerticalPadding({Key? key, this.percentage = .1})
      : assert(percentage >= 0 || percentage < 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = DeviceUtils.getScaledSize(context, percentage);
    return SizedBox(height: height);
  }
}

class VerticalTextPadding extends StatelessWidget {
  final double height;

  const VerticalTextPadding._({Key? key, required this.height})
      : super(key: key);

  factory VerticalTextPadding.with2() {
    return const VerticalTextPadding._(
      height: AppDimens.space2,
    );
  }

  factory VerticalTextPadding.with4() {
    return const VerticalTextPadding._(
      height: AppDimens.space4,
    );
  }

  factory VerticalTextPadding.with6() {
    return const VerticalTextPadding._(
      height: AppDimens.space6,
    );
  }

  factory VerticalTextPadding.with8() {
    return const VerticalTextPadding._(
      height: AppDimens.space8,
    );
  }

  factory VerticalTextPadding.with10() {
    return const VerticalTextPadding._(
      height: AppDimens.space10,
    );
  }

  factory VerticalTextPadding.with12() {
    return const VerticalTextPadding._(
      height: AppDimens.space12,
    );
  }

  factory VerticalTextPadding.with14() {
    return const VerticalTextPadding._(
      height: AppDimens.space14,
    );
  }

  factory VerticalTextPadding.with16() {
    return const VerticalTextPadding._(
      height: AppDimens.space16,
    );
  }

  factory VerticalTextPadding.with18() {
    return const VerticalTextPadding._(
      height: AppDimens.space18,
    );
  }

  factory VerticalTextPadding.with20() {
    return const VerticalTextPadding._(
      height: AppDimens.space20,
    );
  }

  factory VerticalTextPadding.with24() {
    return const VerticalTextPadding._(
      height: AppDimens.space24,
    );
  }

  factory VerticalTextPadding.with32() {
    return const VerticalTextPadding._(
      height: AppDimens.space32,
    );
  }

  factory VerticalTextPadding.with40() {
    return const VerticalTextPadding._(
      height: AppDimens.space40,
    );
  }

  factory VerticalTextPadding.betweenElementsSection() {
    return const VerticalTextPadding._(
      height: AppDimens.space16,
    );
  }

  factory VerticalTextPadding.betweenSection() {
    return const VerticalTextPadding._(
      height: AppDimens.space16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
