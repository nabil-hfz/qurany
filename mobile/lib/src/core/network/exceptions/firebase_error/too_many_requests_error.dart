import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class TooManyRequestError extends BaseError {
  TooManyRequestError() : super(message: translate.err_too_many_requests);
}
