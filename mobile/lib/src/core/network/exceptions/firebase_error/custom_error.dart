import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';

import 'base_error.dart';

class CustomError extends BaseError {
  CustomError({String? message})
      : super(message: message ?? translate.error_unexpected);

  @override
  String toString() {
    return "CustomError(message: $message, statusCode: $statusCode)";
  }
}
