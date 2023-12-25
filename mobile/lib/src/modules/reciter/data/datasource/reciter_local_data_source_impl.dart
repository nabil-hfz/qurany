import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/models/empty_result/empty_result_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';

import 'reciter_data_source_i.dart';

@Singleton()
class ReciterLocalDataSource implements IReciterDataSource {
  const ReciterLocalDataSource();

  @override
  Future<Result<List<ReciterModel>>> getReciters({
    CancelToken? cancelToken,
  }) {
    // TODO: implement getServices
    throw UnimplementedError();
  }

  @override
  Future<Result<ReciterModel>> createReciter(
      {required ReciterModel reciter, CancelToken? cancelToken}) {
    // TODO: implement createReciter
    throw UnimplementedError();
  }

  @override
  Future<Result<EmptyResultModel>> deleteReciter(
      {required String id, CancelToken? cancelToken}) {
    // TODO: implement deleteReciter
    throw UnimplementedError();
  }

  @override
  Future<Result<ReciterModel>> getReciter(
      {required String id, CancelToken? cancelToken}) {
    // TODO: implement getReciter
    throw UnimplementedError();
  }

  @override
  Future<Result<ReciterModel>> updateReciter(
      {required ReciterModel reciter, CancelToken? cancelToken}) {
    // TODO: implement updateReciter
    throw UnimplementedError();
  }
}
