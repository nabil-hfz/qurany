import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/constants/app_endpoints.dart';
import 'package:kawtharuna/src/core/managers/network/dio_client.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/empty_result/empty_result_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/library/data/models/library_model.dart';

import 'library_data_source_i.dart';

@Singleton()
class LibraryRemoteDataSource implements IFileEntryDataSource {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  LibraryRemoteDataSource(this._dioClient) {
    _dioClient.toString();
  }

  @override
  Future<Result<FileEntryModel>> getFileEntryDetails({
    required String id,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.get<FileEntryModel>(
      AppEndpoints.getFileEntryDetails(id),
      cancelToken: cancelToken,
      converterMap: (json) {
        return FileEntryModel.fromJson(json);
      },
    );
  }

  @override
  Future<Result<LibraryListModel>> getLibraryFileEntries({
    CancelToken? cancelToken,
    required BaseFilter filter,
  }) async {
    return await _dioClient.get<LibraryListModel>(
      AppEndpoints.getLibraryFileEntries,
      queryParameters: filter.toJson(),
      cancelToken: cancelToken,
      converterMap: (json) {
        return LibraryListModel.fromJson(json);
      },
    );
  }

  @override
  Future<Result<FileEntryModel>> increaseFileDownloadsCount({
    required int fileId,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.put<FileEntryModel>(
      AppEndpoints.increaseFileDownloadsCount(fileId),
      cancelToken: cancelToken,
      converter: (json) {
        return FileEntryModel.fromJson(json as Map<String, dynamic>);
      },
    );
  }

  @override
  Future<Result<FileEntryModel>> increaseFileViewsCount({
    required int fileId,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.put<FileEntryModel>(
      AppEndpoints.increaseFileViewsCount(fileId),
      cancelToken: cancelToken,
      converter: (json) {
        return FileEntryModel.fromJson(json as Map<String, dynamic>);
      },
    );
  }
}
