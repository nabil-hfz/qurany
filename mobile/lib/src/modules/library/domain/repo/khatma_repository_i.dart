import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';

abstract class IKhatmaRepository {
  const IKhatmaRepository();

  Future<Result<KhatmatListEntity>> getKhatmat({
    CancelToken? cancelToken,
  });

  Future<Result<KhatmaEntity>> getKhatma({
    required String id,
    CancelToken? cancelToken,
  });
}
