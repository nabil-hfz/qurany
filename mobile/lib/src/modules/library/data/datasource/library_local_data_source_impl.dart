import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/library/data/models/library_model.dart';

import 'library_data_source_i.dart';

@Singleton()
class KhatmaLocalDataSource implements IFileEntryDataSource {
  const KhatmaLocalDataSource();

  @override
  Future<Result<LibraryListModel>> getLibraryFileEntries({
    CancelToken? cancelToken,
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
}
