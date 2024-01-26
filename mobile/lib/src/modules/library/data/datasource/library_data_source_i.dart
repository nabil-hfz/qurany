import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
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
}
