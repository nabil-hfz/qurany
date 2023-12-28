import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kawtharuna/src/core/data_source/base_repository.dart';
import 'package:kawtharuna/src/core/entity/base/empty_result_entity.dart';
import 'package:kawtharuna/src/core/models/empty_result/empty_result_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/reciter/data/datasource/reciter_local_data_source_impl.dart';
import 'package:kawtharuna/src/modules/reciter/data/datasource/reciter_remote_data_source_impl.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';
import 'package:kawtharuna/src/modules/reciter/domain/entity/reciter_entity.dart';

import 'reciter_repository_i.dart';

@Singleton()
class ImplReciterRepository extends IReciterRepository {
  // data source object
  final InternetConnectionChecker _connectionChecker;
  final ReciterRemoteDataSource _remoteDataSource;
  final ReciterLocalDataSource _localDataSource;

  ImplReciterRepository(
    this._connectionChecker,
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<ReciterEntity>> createReciter({
    required ReciterEntity reciter,
    CancelToken? cancelToken,
  }) async {
    _connectionChecker.toString();
    _localDataSource.toString();
    final result = await _remoteDataSource.createReciter(
      cancelToken: cancelToken,
      reciter: reciter.toModel(),
    );
    return BaseRepository.execute<ReciterModel, ReciterEntity>(
      remoteResult: result,
    );
  }

  @override
  Future<Result<ReciterEntity>> getReciter({
    required String id,
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.getReciter(
      cancelToken: cancelToken,
      id: id,
    );
    return BaseRepository.execute<ReciterModel, ReciterEntity>(
      remoteResult: result,
    );
  }

  @override
  Future<Result<RecitersListEntity>> getReciters({
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.getReciters(
      cancelToken: cancelToken,
    );
    return BaseRepository.execute(
      remoteResult: result,
    );
  }

  @override
  Future<Result<EmptyResultEntity>> deleteReciter({
    required String id,
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.deleteReciter(
      cancelToken: cancelToken,
      id: id,
    );
    return BaseRepository.execute<EmptyResultModel, EmptyResultEntity>(
      remoteResult: result,
    );
  }
}
