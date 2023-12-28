import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';
import 'package:kawtharuna/src/core/models/localization/localized_model.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';

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
  final int? id;
  final LocalizedModel? name;
  final ReciterModel? reciter;

  KhatmaModel({
    this.id,
    this.name,
    this.reciter,
  });

  factory KhatmaModel.fromJson(Map<String, dynamic> json) =>
      _$KhatmaModelFromJson(json);

  Map<String, dynamic> toJson() => _$KhatmaModelToJson(this);

  @override
  KhatmaEntity toEntity() {
    return KhatmaEntity(
      id: id ?? -1,
      name: name?.toEntity(),
      reciter: reciter?.toEntity(),
    );
  }
}
//
// @JsonSerializable(anyMap: true)
// class Reciter {
//   @JsonKey(name: "name")
//   final Name? name;
//   @JsonKey(name: "id")
//   final int? id;
//   @JsonKey(name: "image")
//   final String? image;
//
//   Reciter({
//     this.name,
//     this.id,
//     this.image,
//   });
//
//   factory Reciter.fromJson(Map<String, dynamic> json) =>
//       _$ReciterFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ReciterToJson(this);
// }
