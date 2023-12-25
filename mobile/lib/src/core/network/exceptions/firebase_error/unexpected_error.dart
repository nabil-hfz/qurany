import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class UnExpectedError extends BaseError {
  UnExpectedError() : super(message: translate.err_unexpected_error_happened);
}
