import 'package:dio/dio.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';

abstract class IRecitationRepository {
  const IRecitationRepository();

  Future<Result<RecitationsListEntity>> getRecitations({
    CancelToken? cancelToken,
  });

  Future<Result<RecitationEntity>> getRecitation({
    required String id,
    CancelToken? cancelToken,
  });
}
