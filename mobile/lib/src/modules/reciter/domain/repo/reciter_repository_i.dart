import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/entity/base/empty_result_entity.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/reciter/domain/entity/reciter_entity.dart';

abstract class IReciterRepository {
  const IReciterRepository();

  Future<Result<RecitersListEntity>> getReciters({
    CancelToken? cancelToken,
  });

  Future<Result<ReciterEntity>> getReciter({
    required String id,
    CancelToken? cancelToken,
  });

  Future<Result<ReciterEntity>> createReciter({
    required ReciterEntity reciter,
    CancelToken? cancelToken,
  });

  Future<Result<EmptyResultEntity>> deleteReciter({
    required String id,
    CancelToken? cancelToken,
  });
}
