import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';

import '../managers.dart';

class ErrorUtil {
  static String specialCode = '1000';
  static String typeErrorCode = '2000';
  static String unKnowErrorCode = '3000';

  ///
  /// General method that tries to infer the type of error according to
  /// all [Dio]'s errors and returns a special kind of error for each
  /// case that matches the current error.
  /// Also if an exception was thrown by this function for some reasons
  /// it will returns a [UnexpectedError] with a special code (currently
  /// [specialCode] this should replace with another value more suitable one) to
  /// indicate that is error is happening on the side of the application
  /// regardless of how this is produced..
  static BaseError handleError(dynamic error) {
    String defaultError = translate.error_unexpected;
    return CustomError(message: translate.error_unexpected);
    // try {
    //   AppUtils.debugPrint('ErrorUtil handleError '
    //       'error is $error | '
    //       'type is  ${error.runtimeType}');
    //   if (error is DioError) {
    //     switch (error.type) {
    //       case DioErrorType.cancel:
    //         return CancelDioError(
    //           statusCode: error.response?.statusCode?.toString() ??
    //               DioErrorType.cancel.name,
    //         );
    //       case DioErrorType.connectionTimeout:
    //         return ConnectTimeoutDioError(
    //           statusCode: error.response?.statusCode?.toString() ??
    //               DioErrorType.cancel.name,
    //         );
    //       case DioErrorType.receiveTimeout:
    //         return ReceiveTimeoutDioError(
    //           statusCode: error.response?.statusCode?.toString() ??
    //               DioErrorType.cancel.name,
    //         );
    //       case DioErrorType.badResponse:
    //         return _handleDioResponseError(
    //           error.response?.statusCode,
    //           error.response?.data,
    //         );
    //       case DioErrorType.sendTimeout:
    //         return SendTimeoutDioError(
    //           statusCode: error.response?.statusCode?.toString() ??
    //               DioErrorType.cancel.name,
    //         );
    //       case DioErrorType.unknown:
    //       default:
    //         return ConnectionDioError(
    //           statusCode: error.response?.statusCode?.toString() ??
    //               DioErrorType.cancel.name,
    //         );
    //     }
    //   } else {
    //     // TODO : OMAR Here we should customize the message
    //     // Should be replaced ...
    //     if (error is TypeError) {
    //       return UnexpectedError(
    //         message: error.toString(),
    //         statusCode: typeErrorCode,
    //       );
    //     }
    //
    //     // TODO : OMAR Here we should customize the message
    //     // Should be replaced ...
    //     return UnexpectedError(
    //       message: error.toString(),
    //       statusCode: unKnowErrorCode,
    //     );
    //     // TODO : OMAR I deleted this because it has no sense here
    //     // WHY: because here we surly know that this object [error]
    //     // is not a [DioError] any more ....
    //     // return UnexpectedError(statusCode: error.response?.statusCode);
    //   }
    // } catch (err, sTrace) {
    //   log('ErrorUtil => handleError: error is $err');
    //   log('ErrorUtil => handleError: stackTrace is $sTrace');
    //
    //   return UnexpectedError(
    //     message: defaultError,
    //     statusCode: specialCode,
    //   );
    // }
  }

// static BaseError _handleDioResponseError(int? statusCode, dynamic error) {
//   /// if you want to do something depend on the status code
//   switch (statusCode) {
//     case 400:
//       return BadRequestDioError(
//           message: error['message'] as String,
//           statusCode: statusCode.toString());
//     case 404:
//       return NotFoundDioError(
//           message: error['message'] as String,
//           statusCode: statusCode.toString());
//     case 500:
//       return InternalServerError(statusCode: statusCode.toString());
//     default:
//       return UnexpectedError(
//           message: translate.error_unexpected,
//           statusCode: statusCode.toString());
//   }
// }
}
