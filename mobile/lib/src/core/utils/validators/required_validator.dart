import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';

import 'base_validator.dart';

class RequiredValidator extends BaseValidator {
  RequiredValidator();

  @override
  String getMessage(BuildContext? context) {
    return translate.validator_this_field_is_required;
  }

  @override
  bool validate(String? value) {
    return value?.isNotEmpty ?? false;
  }
}
