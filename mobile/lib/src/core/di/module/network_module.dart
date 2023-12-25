import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:kawtharuna/src/core/constants/app_endpoints.dart';
import 'package:kawtharuna/src/core/helpers/hlp_shared_preference.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';

@module
abstract class ServiceModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @lazySingleton
  Dio getDio(SharedPreferenceHelper prefs) {
    final dio = Dio();

    dio
      ..options.baseUrl = AppEndpoints.baseUrl
      ..options.connectTimeout =
          const Duration(seconds: AppEndpoints.connectionTimeout)
      ..options.receiveTimeout =
          const Duration(seconds: AppEndpoints.receiveTimeout)
      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }
      ..interceptors.add(AuthInterceptor())
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            /// todo add secure cache for auth key
            /// Auth Key
            final authKey = await prefs.authToken;

            if (authKey != null) {
              options.headers
                  .putIfAbsent('Authorization', () => 'Bearer $authKey');
            }

            return handler.next(options);
          },
        ),
      )
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 250));

    return dio;
  }
}

class AuthInterceptor extends Interceptor {
  bool isInvalidSession = false;

  // helper class to access your local storage

  AuthInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    isInvalidSession = false;
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    AppUtils.debugPrint('onError in AuthInterceptor $err');
    AppUtils.debugPrint(
        'onError in AuthInterceptor isInvalidSession $isInvalidSession');
    if (err.response?.statusCode == 401 ||
        err.response?.statusCode == 402 ||
        err.response?.statusCode == 403) {
      /// todo : show unauth action
      // Navigator.push(
      //   findDep<AppNavigator>().navigatorKey.currentContext!,
      //
      //   /// todo: there is something wrong here to do
      //   MaterialPageRoute(
      //     builder: (context) => LoginPage(),
      //   ),
      // );
      isInvalidSession = true;
    }
    handler.next(err);

    return;
  }
}

// class AppInterceptors extends Interceptor {
//   final Dio dio;
//
//   AppInterceptors(this.dio);
//
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     return handler.next(options);
//   }
//
//   @override
//   void onError(DioError err, ErrorInterceptorHandler handler) {
//     return handler.next(err);
//   }
//
//   @override
//   void onResponse(
//       Response response, ResponseInterceptorHandler handler) async {
//     return handler.next(response);
//   }
// }
