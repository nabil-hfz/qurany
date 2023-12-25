import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';

import 'base_validator.dart';

class MinLengthValidator extends BaseValidator {
  final int minLength;

  MinLengthValidator({required this.minLength});

  @override
  String getMessage(BuildContext? context) {
    return translate
        .validator_should_be_with_minimum_length_of_characters(minLength);
  }

  @override
  bool validate(String? value) {
    return (value?.length ?? 0) >= minLength;
  }
}
