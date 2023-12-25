import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';

import 'base_validator.dart';

class ValueRangeValidator extends BaseValidator {
  final int min;
  final int max;

  ValueRangeValidator({
    required this.min,
    required this.max,
  });

  @override
  String getMessage(BuildContext? context) {
    return translate.validator_should_be_with_range_of(min, max);
  }

  @override
  bool validate(String? value) {
    int currentValue = int.tryParse(value ?? '0') ?? 0;
    return currentValue >= min && currentValue <= max;
  }
}

class ValueRangeDoubleValidator extends BaseValidator {
  final double min;
  final double max;

  ValueRangeDoubleValidator({
    required this.min,
    required this.max,
  });

  @override
  String getMessage(BuildContext? context) {
    return translate.validator_should_be_with_range_of(min, max);
  }

  @override
  bool validate(String? value) {
    double currentValue = double.tryParse(value ?? '0.0') ?? 0.0;
    return currentValue >= min && currentValue <= max;
  }
}
