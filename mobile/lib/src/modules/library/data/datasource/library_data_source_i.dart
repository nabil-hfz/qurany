import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/empty_result/empty_result_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/library/data/models/library_model.dart';

abstract class IFileEntryDataSource {
  const IFileEntryDataSource();

  Future<Result<LibraryListModel>> getLibraryFileEntries({
    CancelToken? cancelToken,
    required BaseFilter filter,
  });

  Future<Result<FileEntryModel>> getFileEntryDetails({
    required String id,
    CancelToken? cancelToken,
  });

  Future<Result<FileEntryModel>> increaseFileDownloadsCount({
    required int fileId,
    CancelToken? cancelToken,
  });

  Future<Result<FileEntryModel>> increaseFileViewsCount({
    required int fileId,
    CancelToken? cancelToken,
  });
}
