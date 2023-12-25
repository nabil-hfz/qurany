import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';

abstract class BaseRepository {
  const BaseRepository();

  static Result<Entity>
      execute<Model extends BaseModel<Entity>, Entity extends BaseEntity>({
    required Result<Model> remoteResult,
  }) {
    if (remoteResult.hasDataOnly) {
      return Result(
        data: remoteResult.data!.toEntity(),
      );
    } else {
      return Result(error: remoteResult.error);
    }
  }

  static Result<List<Entity>> executeForList<Model extends BaseModel<Entity>,
      Entity extends BaseEntity>({required Result<List<Model>> remoteResult}) {
    if (remoteResult.hasDataOnly) {
      return Result(
        data: remoteResult.data!.map((model) => model.toEntity()).toList(),
      );
    } else {
      return Result(error: remoteResult.error);
    }
  }

  static Result<Object> executeForNoData<Model extends BaseModel<Entity>,
      Entity extends BaseEntity>({
    required Result<Object> remoteResult,
  }) {
    if (remoteResult.hasDataOnly) {
      return Result(data: Object());
    }
    return Result(error: remoteResult.error);
  }
}
