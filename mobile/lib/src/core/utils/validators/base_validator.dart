import 'package:flutter/material.dart';

///
/// It is a base class for 7 types of different validators that accepts
/// a specific [validate] checking method along with a specific validation
/// message. This base class has tha ability to check any number of derived
/// validators as long as they are being inherited from this class.
///
/// The validators are as following:
/// [MatchValidator], [EmailValidator], [MinLengthValidator], [YearValidator],
/// [RequiredValidator], [RequiredSmallMessageValidator], [VerificationCodeValidator].
abstract class BaseValidator {
  bool validate(String? value);

  String getMessage(BuildContext? context);

  static String? validateValue(
    BuildContext? context,
    String? value,
    List<BaseValidator> validators,
    bool isValidationActive,
  ) {
    for (int i = 0; i < validators.length; i++) {
      if (!validators[i].validate(value)) {
        return validators[i].getMessage(context);
      }
    }
    return null;
  }
}
