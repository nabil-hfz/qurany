import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/constants/app_endpoints.dart';
import 'package:kawtharuna/src/core/managers/network/dio_client.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/recitations/data/models/recitation_model.dart';

import 'recitation_data_source_i.dart';

@Singleton()
class RecitationRemoteDataSource implements IRecitationDataSource {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  RecitationRemoteDataSource(this._dioClient) {
    _dioClient.toString();
  }

  @override
  Future<Result<RecitationsListModel>> getRecitations({
    required BaseFilter filter,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.get<RecitationsListModel>(
      AppEndpoints.getRecitations,
      cancelToken: cancelToken,
      queryParameters: filter.toJson(),
      converterMap: (json) {
        return RecitationsListModel.fromJson(json);
      },
    );
  }

  @override
  Future<Result<RecitationModel>> getRecitation({
    required String id,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.get<RecitationModel>(
      AppEndpoints.getRecitationDetails(id),
      cancelToken: cancelToken,
      converterMap: (json) {
        return RecitationModel.fromJson(json);
      },
    );
  }
}
