import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/empty_result/empty_result_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/library/data/models/library_model.dart';

import 'library_data_source_i.dart';

@Singleton()
class LibraryLocalDataSource implements IFileEntryDataSource {
  const LibraryLocalDataSource();

  @override
  Future<Result<LibraryListModel>> getLibraryFileEntries({
    CancelToken? cancelToken,
    required BaseFilter filter,
  }) {
    // TODO: implement getServices
    throw UnimplementedError();
  }

  @override
  Future<Result<FileEntryModel>> getFileEntryDetails({
    required String id,
    CancelToken? cancelToken,
  }) {
    // TODO: implement getKhatma
    throw UnimplementedError();
  }

  @override
  Future<Result<FileEntryModel>> increaseFileDownloadsCount({
    required int fileId,
    CancelToken? cancelToken,
  }) {
    // TODO: implement increaseFileDownloadsCount
    throw UnimplementedError();
  }

  @override
  Future<Result<FileEntryModel>> increaseFileViewsCount({
    required int fileId,
    CancelToken? cancelToken,
  }) {
    // TODO: implement increaseFileViewsCount
    throw UnimplementedError();
  }
}
