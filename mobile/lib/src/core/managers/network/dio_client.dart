import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';

import 'error_util.dart';

@injectable
class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio);

  // Get:-----------------------------------------------------------------------
  Future<Result<BaseModel>> get(
    String uri, {
    required BaseModel Function(Map<String, dynamic>) converter,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      BaseModel r = converter(response.data as Map<String, dynamic>);
      return Result(data: r);
    } catch (err, stackTrace) {
      AppUtils.debugPrint('err: $err, stackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  // Get List:-----------------------------------------------------------------------
  Future<Result<List<T>>> getList<T>(
    String uri, {
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic>) converter,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response<List<T>> response = await _dio.get<List<T>>(
        uri,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      final result = response.data
          ?.map((json) => converter(json as Map<String, dynamic>))
          .toList();
      return Result(data: result);
    } catch (err, stackTrace) {
      AppUtils.debugPrint('err: $err, stackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Result<BaseModel>> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response<BaseModel> response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result(data: response.data);
    } catch (err, stackTrace) {
      AppUtils.debugPrint('err: $err, stackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  Future<Result<BaseModel>> postWithFile(
    String uri, {
    Map<String, dynamic>? data,
    required String fileKey,
    required String filePath,
    required String fileName,
    required String extension,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      Map<String, dynamic> dataMap = {};
      if (data != null) {
        dataMap.addAll(data);
      }

      dataMap.addAll({
        fileKey: await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: MediaType("image", extension),
        ),
      });

      final Response<BaseModel> response = await _dio.post(
        uri,
        data: FormData.fromMap(dataMap),
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result(data: response.data);
    } catch (err, stackTrace) {
      AppUtils.debugPrint('err: $err, stackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Result<BaseModel>> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response<BaseModel> response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Result(data: response.data);
    } catch (err, stackTrace) {
      AppUtils.debugPrint('err: $err, stackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<Result<BaseModel>> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response<BaseModel> response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Result(data: response.data);
    } catch (err, stackTrace) {
      AppUtils.debugPrint('err: $err, stackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }
}
