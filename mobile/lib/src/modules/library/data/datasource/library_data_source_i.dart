import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/khatmat/data/models/khatma_model.dart';
import 'package:kawtharuna/src/modules/library/data/models/library_model.dart';

abstract class IFileEntryDataSource {
  const IFileEntryDataSource();

  Future<Result<LibraryListModel>> getLibraryFileEntries({
    CancelToken? cancelToken,
  });

  Future<Result<FileEntryModel>> getFileEntryDetails({
    required String id,
    CancelToken? cancelToken,
  });
}
