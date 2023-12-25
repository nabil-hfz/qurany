import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';
import 'package:kawtharuna/src/core/network/firebase/firestore_service.dart';
import 'package:kawtharuna/src/modules/reciter/domain/entity/reciter_entity.dart';

part 'reciter_model.g.dart';

@JsonSerializable(anyMap: true)
class ReciterModel extends BaseModel<ReciterEntity> {
  @JsonKey(
    fromJson: ReferenceIdConverter.fromJson,
    toJson: ReferenceIdConverter.toJson,
  )
  final String? id;

  @JsonKey(
    fromJson: ServerTimestampConverter.fromJson,
    toJson: ServerTimestampConverter.toJson,
  )
  final DateTime? createdDate;
  final String? image;
  final LocalizedModel? name;
  final int? numberOfSeals;
  final LocalizedModel? bio;
  final int? totalNumberOfPlay;
  final int? totalNumberOfDownload;

  ReciterModel({
    this.id,
    this.createdDate,
    this.image,
    this.name,
    this.numberOfSeals,
    this.bio,
    this.totalNumberOfPlay,
    this.totalNumberOfDownload,
  });

  factory ReciterModel.fromSnapShot(Map<String, dynamic>? json, String id) {
    json?['id'] = id;
    return _$ReciterModelFromJson(json!);
  }

  factory ReciterModel.fromJson(Map<String, dynamic> json) =>
      _$ReciterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReciterModelToJson(this);

  @override
  ReciterEntity toEntity() {
    return ReciterEntity(
      id: id ?? '',
      createdDate: createdDate,
      image: image ?? '',
      name: name?.toEntity(),
      numberOfSeals: numberOfSeals ?? 0,
      bio: bio?.toEntity(),
      totalNumberOfPlay: totalNumberOfPlay ?? 0,
      totalNumberOfDownload: totalNumberOfDownload ?? 0,
    );
  }
}

@JsonSerializable(anyMap: true)
class LocalizedModel extends BaseModel<LocalizedEntity> {
  final String? ar;
  final String? en;

  LocalizedModel({
    this.ar,
    this.en,
  });

  factory LocalizedModel.fromSnapShot(Map<String, dynamic>? json, String id) {
    return _$LocalizedModelFromJson(json!);
  }

  factory LocalizedModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizedModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizedModelToJson(this);

  @override
  LocalizedEntity toEntity() {
    return LocalizedEntity(
      ar: ar,
      en: en,
    );
  }
}
