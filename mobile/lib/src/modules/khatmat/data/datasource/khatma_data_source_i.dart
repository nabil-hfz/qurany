import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/khatmat/data/models/khatma_model.dart';

abstract class IKhatmaDataSource {
  const IKhatmaDataSource();

  Future<Result<KhatmatListModel>> getKhatmat({
    CancelToken? cancelToken,
  });

  Future<Result<KhatmaModel>> getKhatma({
    required String id,
    CancelToken? cancelToken,
  });
}
