import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';
import 'package:kawtharuna/src/core/models/localization/localized_model.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';

part 'khatma_model.g.dart';

@JsonSerializable(anyMap: true)
class KhatmatListModel extends BaseModel {
  final List<KhatmaModel>? items;

  KhatmatListModel({
    this.items,
  });

  factory KhatmatListModel.fromJson(Map<String, dynamic> json) =>
      _$KhatmatListModelFromJson(json);

  Map<String, dynamic> toJson() => _$KhatmatListModelToJson(this);

  @override
  KhatmatListEntity toEntity() {
    return KhatmatListEntity(
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

@JsonSerializable(anyMap: true)
class KhatmaModel extends BaseModel<KhatmaEntity> {
  final int id;
  final LocalizedModel? name;
  final String? image;
  final int? numberOfKhatmat;
  final LocalizedModel? bio;

  KhatmaModel({
    required this.id,
    this.name,
    this.image,
    this.numberOfKhatmat,
    this.bio,
  });

  factory KhatmaModel.fromSnapShot(Map<String, dynamic>? json, String id) {
    return _$KhatmaModelFromJson(json!);
  }

  factory KhatmaModel.fromJson(Map json) => _$KhatmaModelFromJson(json);

  Map<String, dynamic> toJson() => _$KhatmaModelToJson(this);

  @override
  KhatmaEntity toEntity() {
    return KhatmaEntity(
      id: id,
      name: name?.toEntity(),
      image: image,
      numberOfKhatmat: numberOfKhatmat ?? 0,
      bio: bio?.toEntity(),
    );
  }
}
