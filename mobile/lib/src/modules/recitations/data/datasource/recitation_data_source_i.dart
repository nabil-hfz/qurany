import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/recitations/data/models/recitation_model.dart';

abstract class IRecitationDataSource {
  const IRecitationDataSource();

  Future<Result<RecitationsListModel>> getRecitations({
    required BaseFilter filter,
    CancelToken? cancelToken,
  });

  Future<Result<RecitationModel>> getRecitation({
    required String id,
    CancelToken? cancelToken,
  });
}
