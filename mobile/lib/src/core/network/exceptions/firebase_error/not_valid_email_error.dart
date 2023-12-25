import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class NotValidEmailError extends BaseError {
  NotValidEmailError() : super(message: translate.err_valid_email);
}
