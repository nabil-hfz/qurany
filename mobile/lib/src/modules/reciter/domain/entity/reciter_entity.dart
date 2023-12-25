import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';

class ReciterEntity extends BaseEntity {
  final String id;
  final DateTime? createdDate;
  final String image;
  final LocalizedEntity? name;
  final int numberOfSeals;
  final LocalizedEntity? bio;
  final int totalNumberOfPlay;
  final int totalNumberOfDownload;

  const ReciterEntity({
    required this.id,
    this.createdDate,
    required this.image,
    required this.name,
    required this.numberOfSeals,
    required this.bio,
    required this.totalNumberOfPlay,
    required this.totalNumberOfDownload,
  });

  ReciterModel toModel() {
    return ReciterModel(
      bio: bio?.toModel(),
      createdDate: createdDate,
      image: image,
      id: id,
      name: name?.toModel(),
      numberOfSeals: numberOfSeals,
      totalNumberOfDownload: totalNumberOfDownload,
      totalNumberOfPlay: totalNumberOfDownload,
    );
  }

  @override
  List<Object?> get props => [
        id,
        createdDate,
        image,
        name,
        numberOfSeals,
        bio,
        totalNumberOfPlay,
        totalNumberOfDownload,
      ];
}

class LocalizedEntity extends BaseEntity {
  final String? ar;
  final String? en;

  const LocalizedEntity({
    this.ar,
    this.en,
  });

  LocalizedModel toModel() {
    return LocalizedModel(
      ar: ar,
      en: en,
    );
  }

  @override
  List<Object?> get props => [
        ar,
        en,
      ];
}
