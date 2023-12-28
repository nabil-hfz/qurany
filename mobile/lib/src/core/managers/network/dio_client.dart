// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/app_constants.dart';
import 'package:kawtharuna/src/core/constants/app_endpoints.dart';
import 'package:kawtharuna/src/core/constants/extension.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';
import 'package:kawtharuna/src/core/utils/utl_app.dart';

// Project imports:

import 'error_util.dart';

@Singleton()
class DioClient {
  // dio instance
  final Dio _dio;

  // injecting dio instance
  DioClient(this._dio);

  static String appendBearerForToken([String? token]) {
    return 'Bearer $token';
  }

  // Get:-----------------------------------------------------------------------
  Future<Result<BaseModel>> get<BaseModel>(
    String uri, {
    BaseModel Function(dynamic)? converter,
    BaseModel Function(Map<String, dynamic>)? converterMap,
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
      BaseModel r;
      if (converterMap != null) {
        r = converterMap(response.data as Map<String, dynamic>);
      } else if (converter != null) {
        r = converter(response.data);
      } else {
        throw NotFoundError('Should pass one converter');
      }
      return Result(data: r);
    } catch (err, stackTrace) {
      appPrint('DioClient get error: $err \nstackTrace: $stackTrace');
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
      final Response response = await _dio.get(
        uri,
        options: options,
        cancelToken: cancelToken,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      );
      final result = response.data
          ?.profile<T>((json) => converter(json as Map<String, dynamic>))
          .toList();
      return Result(data: result as List<T>?);
    } catch (err, stackTrace) {
      appPrint('DioClient getList error: $err \nstackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Result<BaseModel>> post<BaseModel>(
    String uri, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    BaseModel Function(Map<String, dynamic>)? converter,
    BaseModel Function(dynamic)? converterDynamic,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      BaseModel r;
      if (converterDynamic != null) {
        r = converterDynamic(response.data);
      } else {
        r = converter!(response.data as Map<String, dynamic>);
      }
      return Result(data: r);
    } catch (err, stackTrace) {
      appPrint('DioClient post error: $err \nstackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  Future<Result<BaseModel>> postWithFile<BaseModel>(
    String uri, {
    Map<String, dynamic>? data,
    required File? file,
    required FileType? fileType,
    required BaseModel Function(Map<String, dynamic>) converter,
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

      String filePath = file!.path;
      String fileName = file.getFileName;
      String extension = file.getFileExtension;
      const fileKey = AppQueryParameters.file;
      dataMap.addAll({
        fileKey: await MultipartFile.fromFile(
          filePath,
          filename: fileName,
          contentType: MediaType(fileType!.name, extension),
        ),
      });

      FormData formData = FormData.fromMap(dataMap);
      final Response response = await _dio.post(
        uri,
        data: formData,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      BaseModel r = converter(response.data as Map<String, dynamic>);
      return Result(data: r);
    } catch (err, stackTrace) {
      appPrint('DioClient postWithFile error: $err \nstackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Result<BaseModel>> put<BaseModel>(
    String uri, {
    data,
    BaseModel Function(dynamic)? converter,
    BaseModel Function(dynamic)? converterDynamic,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      BaseModel r;
      if (converterDynamic != null) {
        r = converterDynamic(response.data);
      } else {
        r = converter!(response.data);
      }
      return Result(data: r);
    } catch (err, stackTrace) {
      appPrint('DioClient put error: $err \nstackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }

  // Delete:--------------------------------------------------------------------
  Future<Result<BaseModel>> delete<BaseModel>(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    BaseModel Function(Map<String, dynamic>)? converter,
    BaseModel Function(dynamic)? converterDynamic,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      BaseModel r;
      if (converterDynamic != null) {
        r = converterDynamic(response.data);
      } else {
        r = converter!(response.data as Map<String, dynamic>);
      }
      return Result(data: r);
    } catch (err, stackTrace) {
      appPrint('DioClient delete error: $err \nstackTrace: $stackTrace');
      return Result(error: ErrorUtil.handleError(err));
    }
  }
}
