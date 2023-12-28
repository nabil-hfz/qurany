import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/constants/app_endpoints.dart';
import 'package:kawtharuna/src/core/managers/network/dio_client.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/khatmat/data/models/khatma_model.dart';

import 'khatma_data_source_i.dart';

@Singleton()
class KhatmaRemoteDataSource implements IKhatmaDataSource {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  KhatmaRemoteDataSource(this._dioClient) {
    _dioClient.toString();
  }

  @override
  Future<Result<KhatmaModel>> getKhatma({
    required String id,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.get<KhatmaModel>(
      AppEndpoints.getKhatmaDetails(id),
      cancelToken: cancelToken,
      converterMap: (json) {
        return KhatmaModel.fromJson(json);
      },
    );
  }

  @override
  Future<Result<KhatmatListModel>> getKhatmat({
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.get<KhatmatListModel>(
      AppEndpoints.getKhatmat,
      cancelToken: cancelToken,
      converterMap: (json) {
        return KhatmatListModel.fromJson(json);
      },
    );
  }
}
