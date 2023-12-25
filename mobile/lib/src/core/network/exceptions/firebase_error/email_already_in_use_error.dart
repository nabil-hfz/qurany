import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class EmailAlreadyInUseError extends BaseError {
  EmailAlreadyInUseError()
      : super(message: translate.err_this_email_is_already_in_use);
}
