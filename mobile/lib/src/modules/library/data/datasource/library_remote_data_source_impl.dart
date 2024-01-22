import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/constants/app_endpoints.dart';
import 'package:kawtharuna/src/core/managers/network/dio_client.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/library/data/models/library_model.dart';

import 'library_data_source_i.dart';

@Singleton()
class FileEntryRemoteDataSource implements IFileEntryDataSource {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  FileEntryRemoteDataSource(this._dioClient) {
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
  }) async {
    return await _dioClient.get<LibraryListModel>(
      AppEndpoints.getLibraryFileEntries,
      cancelToken: cancelToken,
      converterMap: (json) {
        return LibraryListModel.fromJson(json);
      },
    );
  }
}
