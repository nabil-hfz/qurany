import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/empty_result/empty_result_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';

abstract class IReciterDataSource {
  const IReciterDataSource();

  Future<Result<RecitersListModel>> getReciters({
    CancelToken? cancelToken,
  });

  Future<Result<ReciterModel>> getReciter({
    required String id,
    CancelToken? cancelToken,
  });

  Future<Result<ReciterModel>> createReciter({
    required ReciterModel reciter,
    CancelToken? cancelToken,
  });

  Future<Result<EmptyResultModel>> deleteReciter({
    required String id,
    CancelToken? cancelToken,
  });
}
