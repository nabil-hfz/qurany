import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/entity/base/empty_result_entity.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/library/domain/entity/library_entity.dart';

abstract class ILibraryRepository {
  const ILibraryRepository();

  Future<Result<LibraryListEntity>> getLibraryFileEntries({
    CancelToken? cancelToken,
    required BaseFilter filter,
  });

  Future<Result<FileEntryEntity>> getFileEntry({
    required String id,
    CancelToken? cancelToken,
  });

  Future<Result<FileEntryEntity>> increaseFileViewsCount({
    required int fileId,
    CancelToken? cancelToken,
  });

  Future<Result<FileEntryEntity>> increaseFileDownloadsCount({
    required int fileId,
    CancelToken? cancelToken,
  });
}
