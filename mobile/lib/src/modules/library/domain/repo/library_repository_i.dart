import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/library/domain/entity/library_entity.dart';

abstract class ILibraryRepository {
  const ILibraryRepository();

  Future<Result<LibraryListEntity>> getLibraryFileEntries({
    CancelToken? cancelToken,
  });

  Future<Result<FileEntryEntity>> getFileEntry({
    required String id,
    CancelToken? cancelToken,
  });
}
