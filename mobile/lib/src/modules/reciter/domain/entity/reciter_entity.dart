import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';

class RecitersListEntity extends BaseEntity {
  final List<ReciterEntity> items;

  const RecitersListEntity({required this.items});

  @override
  List<Object?> get props => [
        items,
      ];
}

class ReciterEntity extends BaseEntity {
  final int id;
  final LocalizedEntity? name;
  final String? image;
  final int numberOfKhatmat;
  final LocalizedEntity? bio;

  const ReciterEntity({
    required this.id,
    this.name,
    required this.image,
    required this.numberOfKhatmat,
    this.bio,
  });

  ReciterModel toModel() {
    return ReciterModel(id: 1);
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
