import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

class DuplicatedCredentialError extends BaseError {
  DuplicatedCredentialError()
      : super(
          message: translate.err_duplicated_credential,
        );
}
