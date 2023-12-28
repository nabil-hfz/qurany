import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/recitations/data/models/recitation_model.dart';

import 'recitation_data_source_i.dart';

@Singleton()
class RecitationLocalDataSource implements IRecitationDataSource {
  const RecitationLocalDataSource();

  @override
  Future<Result<RecitationsListModel>> getRecitations({
    CancelToken? cancelToken,
  }) {
    // TODO: implement getServices
    throw UnimplementedError();
  }

  @override
  Future<Result<RecitationModel>> getRecitation({
    required String id,
    CancelToken? cancelToken,
  }) {
    // TODO: implement getRecitation
    throw UnimplementedError();
  }
}
