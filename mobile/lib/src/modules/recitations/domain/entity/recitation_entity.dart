import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';

class RecitationsListEntity extends BaseEntity {
  final List<RecitationEntity> items;

  const RecitationsListEntity({required this.items});

  @override
  List<Object?> get props => [
        items,
      ];
}

class RecitationEntity extends BaseEntity {
  final int id;
  final int khatmaId;
  final LocalizedEntity? title;
  final String? audio;
  final String? image;
  final int durationInSecond;

  const RecitationEntity({
    required this.id,
    required this.khatmaId,
    this.title,
    this.audio,
    this.image,
    required this.durationInSecond,
  });

  @override
  List<Object?> get props => [
        id,
        khatmaId,
        title,
        audio,
        image,
        durationInSecond,
      ];
}
