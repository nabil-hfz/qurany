import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';

import 'base_validator.dart';

class MatchValidator extends BaseValidator {
  String value;

  MatchValidator({required this.value});

  @override
  String getMessage(BuildContext? context) {
    return translate.validator_it_does_not_match;
  }

  @override
  bool validate(String? value) {
    return value == this.value;
  }
}
