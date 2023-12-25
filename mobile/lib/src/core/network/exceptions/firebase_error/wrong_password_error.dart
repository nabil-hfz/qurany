import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class WrongPasswordError extends BaseError {
  WrongPasswordError() : super(message: translate.err_wrong_email_or_password);
}
