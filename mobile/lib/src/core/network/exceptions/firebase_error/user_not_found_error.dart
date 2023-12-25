import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class UserNotFoundError extends BaseError {
  UserNotFoundError() : super(message: translate.err_user_not_found);
}
