import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kawtharuna/src/core/data_source/base_repository.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/recitations/data/datasource/recitation_local_data_source_impl.dart';
import 'package:kawtharuna/src/modules/recitations/data/datasource/recitation_remote_data_source_impl.dart';
import 'package:kawtharuna/src/modules/recitations/data/models/recitation_model.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
import 'package:kawtharuna/src/modules/recitations/domain/repo/recitation_repository_i.dart';

@Singleton()
class ImplRecitationRepository extends IRecitationRepository {
  // data source object
  final InternetConnectionChecker _connectionChecker;
  final RecitationRemoteDataSource _remoteDataSource;
  final RecitationLocalDataSource _localDataSource;

  ImplRecitationRepository(
    this._connectionChecker,
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<RecitationEntity>> getRecitation({
    required String id,
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.getRecitation(
      cancelToken: cancelToken,
      id: id,
    );
    return BaseRepository.execute<RecitationModel, RecitationEntity>(
      remoteResult: result,
    );
  }

  @override
  Future<Result<RecitationsListEntity>> getRecitations({
    CancelToken? cancelToken,
  }) async {
    final result = await _remoteDataSource.getRecitations(
      cancelToken: cancelToken,
    );
    return BaseRepository.execute(
      remoteResult: result,
    );
  }
}
