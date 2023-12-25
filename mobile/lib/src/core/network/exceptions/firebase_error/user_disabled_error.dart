import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class UserDisabledError extends BaseError {
  UserDisabledError() : super(message: translate.err_user_disabled);
}
