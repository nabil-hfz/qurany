import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';
import 'package:kawtharuna/src/modules/reciter/domain/entity/reciter_entity.dart';

class KhatmatListEntity extends BaseEntity {
  final List<KhatmaEntity> items;

  const KhatmatListEntity({required this.items});

  @override
  List<Object?> get props => [
        items,
      ];
}

class KhatmaEntity extends BaseEntity {
  final int id;
  final LocalizedEntity? name;
  final ReciterEntity? reciter;

  const KhatmaEntity({
    required this.id,
    this.name,
    this.reciter,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        reciter,
      ];
}
