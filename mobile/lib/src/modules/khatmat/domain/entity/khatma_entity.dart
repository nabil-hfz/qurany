import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';
import 'package:kawtharuna/src/modules/khatmat/data/models/khatma_model.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';

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
  final String? image;
  final int numberOfKhatmat;
  final LocalizedEntity? bio;

  const KhatmaEntity({
    required this.id,
    this.name,
    required this.image,
    required this.numberOfKhatmat,
    this.bio,
  });

  KhatmaModel toModel() {
    return KhatmaModel(id: 1);
  }

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        numberOfKhatmat,
        bio,
      ];
}
