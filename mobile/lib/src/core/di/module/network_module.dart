// Package imports:
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/constants/app_endpoints.dart';
import 'package:kawtharuna/src/core/helpers/hlp_shared_preference.dart';
import 'package:kawtharuna/src/core/utils/utl_app.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final appOptions = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

@module
abstract class ServiceModule {
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @LazySingleton()
  Future<Dio> getDio(SharedPreferenceHelper sharedPreference) async {
    final dio = Dio();

    dio
      ..options.baseUrl = AppEndpoints.baseUrl
      ..options.connectTimeout =
          const Duration(seconds: AppEndpoints.connectionTimeout)
      ..options.receiveTimeout =
          const Duration(seconds: AppEndpoints.receiveTimeout)
      ..options.headers = appOptions
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: false,
          maxWidth: 100,
        ),
      )
      ..interceptors.add(AuthInterceptor(dio, sharedPreference));

    return dio;
  }
}

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final SharedPreferenceHelper sharedPreference;
  bool _isRefreshing = false;
  int tryingCount = 0;

  AuthInterceptor(this._dio, this.sharedPreference) {
    _dio.toString();
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authKey = await sharedPreference.authToken;
    options.headers['Authorization'] = authKey;
    appPrint('Authorization is ${options.headers['Authorization']}');

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    if (err.response?.statusCode == 401 && !_isRefreshing && tryingCount < 3) {
      _isRefreshing = true;
      tryingCount++;
      // try {
      //   /// assume receiving the token has no errors
      //   /// to check `null-safety` and error handling
      //   /// please check inside the [onRequest] closure
      //   // final newToken = await _getToken();
      //
      //   options.headers['Authorization'] = newToken;
      //   appPrint('New Token has been saved is newToken $newToken');
      //
      //   _isRefreshing = false;
      //
      //   if (options.headers['Authorization'] != null) {
      //     appPrint('the token has been updated');
      //
      //     /// since the api has no state, force to pass the 401 error
      //     /// by adding query parameter
      //     final originResult = await _dio.fetch(options..path);
      //     // print('originResult.statusCode is ${originResult.statusCode}');
      //     tryingCount = 0;
      //     if (originResult.statusCode != null &&
      //         originResult.statusCode! ~/ 100 == 2) {
      //       return handler.resolve(originResult);
      //     }
      //   }
      //   appPrint('the token has not been updated');
      //   return handler.reject(
      //     DioException(
      //       requestOptions: options,
      //       error: err,
      //       response: err.response,
      //       stackTrace: err.stackTrace,
      //       message: err.message,
      //       type: err.type,
      //     ),
      //   );
      // } catch (e) {
      //   _isRefreshing = false;
      //   appPrint('the token has not been updated');
      //   return handler.reject(
      //     DioException(
      //       requestOptions: options,
      //       error: err,
      //       response: err.response,
      //       stackTrace: err.stackTrace,
      //       message: err.message,
      //       type: err.type,
      //     ),
      //   );
      // }
    }
    appPrint('the token has not been updated');
    return handler.reject(
      DioException(
        requestOptions: options,
        error: err,
        response: err.response,
        stackTrace: err.stackTrace,
        message: err.message,
        type: err.type,
      ),
    );
  }

// Future _getToken() async {
//   final newToken = await refreshToken();
//   if (newToken != null) {
//     // here we save the token without adding Bearer as we appended it in when saving it.
//     await sharedPreference.saveAuthToken(newToken);
//   }
//   final appToken = 'Bearer $newToken';
//   return appToken;
// }
//
// Future<String?> refreshToken() async {
//   final loginMethod = await sharedPreference.checkLoginMethod;
//   if (loginMethod == AppStrings.emailAndPassword) {
//     final email = await sharedPreference.email;
//     final password = await sharedPreference.password;
//     if (email == null || password == null) return null;
//     final response = await _dio.post(
//       AppEndpoints.login,
//       data: SignInRequestModel(
//         password: password,
//         username: email,
//       ),
//     );
//     return response.data?['token'];
//   } else if (loginMethod != null && loginMethod == AppStrings.socialMedia) {
//     final socialMediaType = await sharedPreference.getLoginMethodType;
//     //
//     if (socialMediaType == null || socialMediaType == SocialLoginType.none) {
//       return null;
//     }
//     String url =
//     ImplAuthRemoteDataSource.getSocialUrlBasedOnType(socialMediaType);
//
//     final socialMediaToken = await sharedPreference.getSocialMediaToken;
//
//     final response = await _dio.post(
//       url,
//       queryParameters:
//       SocialLoginRequestModel(token: socialMediaToken).toJson(),
//     );
//     return response.data?['token'];
//   }
//   return null;
// }
}
