import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/khatmat/data/models/khatma_model.dart';

import 'khatma_data_source_i.dart';

@Singleton()
class KhatmaLocalDataSource implements IKhatmaDataSource {
  const KhatmaLocalDataSource();

  @override
  Future<Result<KhatmatListModel>> getKhatmat({
    CancelToken? cancelToken,
  }) {
    // TODO: implement getServices
    throw UnimplementedError();
  }

  @override
  Future<Result<KhatmaModel>> getKhatma({
    required String id,
    CancelToken? cancelToken,
  }) {
    // TODO: implement getKhatma
    throw UnimplementedError();
  }
}
