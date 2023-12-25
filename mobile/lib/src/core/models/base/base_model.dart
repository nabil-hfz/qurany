import 'package:kawtharuna/src/core/entity/base/base_entity.dart';

abstract class BaseModel<T extends BaseEntity> {
  T toEntity();
}
