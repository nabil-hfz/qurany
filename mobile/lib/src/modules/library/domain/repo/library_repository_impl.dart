import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kawtharuna/src/core/data_source/base_repository.dart';
import 'package:kawtharuna/src/core/entity/base/empty_result_entity.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/library/data/datasource/library_local_data_source_impl.dart';
import 'package:kawtharuna/src/modules/library/data/datasource/library_remote_data_source_impl.dart';

import '../entity/library_entity.dart';
import 'library_repository_i.dart';

@Singleton()
class ImplLibraryRepository extends ILibraryRepository {
  // data source object
  final InternetConnectionChecker _connectionChecker;
  final LibraryRemoteDataSource _remoteDataSource;
  final LibraryLocalDataSource _localDataSource;

  ImplLibraryRepository(
    this._connectionChecker,
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<LibraryListEntity>> getLibraryFileEntries({
    CancelToken? cancelToken,
    required BaseFilter filter,
  }) async {
    final result = await _remoteDataSource.getLibraryFileEntries(
      cancelToken: cancelToken,
      filter: filter,
    );
    return BaseRepository.execute(
      remoteResult: result,
    );
  }

  @override
  Future<Result<FileEntryEntity>> getFileEntry({
    required String id,
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.getFileEntryDetails(
      cancelToken: cancelToken,
      id: id,
    );
    return BaseRepository.execute(
      remoteResult: result,
    );
  }

  @override
  Future<Result<FileEntryEntity>> increaseFileDownloadsCount({
    required int fileId,
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.increaseFileDownloadsCount(
      cancelToken: cancelToken,
      fileId: fileId,
    );
    return BaseRepository.execute(
      remoteResult: result,
    );
  }

  @override
  Future<Result<FileEntryEntity>> increaseFileViewsCount({
    required int fileId,
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.increaseFileViewsCount(
      cancelToken: cancelToken,
      fileId: fileId,
    );
    return BaseRepository.execute(
      remoteResult: result,
    );
  }
}
