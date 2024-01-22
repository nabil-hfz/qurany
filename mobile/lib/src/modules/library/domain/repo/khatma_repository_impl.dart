import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kawtharuna/src/core/data_source/base_repository.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/khatmat/data/datasource/khatma_local_data_source_impl.dart';
import 'package:kawtharuna/src/modules/khatmat/data/datasource/khatma_remote_data_source_impl.dart';
import 'package:kawtharuna/src/modules/khatmat/data/models/khatma_model.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';

import 'khatma_repository_i.dart';

@Singleton()
class ImplKhatmaRepository extends IKhatmaRepository {
  // data source object
  final InternetConnectionChecker _connectionChecker;
  final KhatmaRemoteDataSource _remoteDataSource;
  final KhatmaLocalDataSource _localDataSource;

  ImplKhatmaRepository(
    this._connectionChecker,
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<KhatmaEntity>> getKhatma({
    required String id,
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.getKhatma(
      cancelToken: cancelToken,
      id: id,
    );
    return BaseRepository.execute<KhatmaModel, KhatmaEntity>(
      remoteResult: result,
    );
  }

  @override
  Future<Result<KhatmatListEntity>> getKhatmat({
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.getKhatmat(
      cancelToken: cancelToken,
    );
    return BaseRepository.execute(
      remoteResult: result,
    );
  }
}
