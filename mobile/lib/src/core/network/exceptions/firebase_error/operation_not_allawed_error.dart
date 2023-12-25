import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class OperationNotAllowedError extends BaseError {
  OperationNotAllowedError()
      : super(message: translate.err_operation_not_allowed);
}
