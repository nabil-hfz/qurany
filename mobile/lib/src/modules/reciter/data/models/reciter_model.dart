import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';
import 'package:kawtharuna/src/core/models/localization/localized_model.dart';
import 'package:kawtharuna/src/modules/reciter/domain/entity/reciter_entity.dart';

part 'reciter_model.g.dart';

@JsonSerializable(anyMap: true)
class RecitersListModel extends BaseModel {
  final List<ReciterModel>? items;

  RecitersListModel({
    this.items,
  });

  factory RecitersListModel.fromJson(Map<String, dynamic> json) =>
      _$RecitersListModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecitersListModelToJson(this);

  @override
  RecitersListEntity toEntity() {
    return RecitersListEntity(
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

@JsonSerializable(anyMap: true)
class ReciterModel extends BaseModel<ReciterEntity> {
  final int id;
  final LocalizedModel? name;
  final String? image;
  final int? numberOfKhatmat;
  final LocalizedModel? bio;

  ReciterModel({
    required this.id,
    this.name,
    this.image,
    this.numberOfKhatmat,
    this.bio,
  });

  factory ReciterModel.fromSnapShot(Map<String, dynamic>? json, String id) {
    return _$ReciterModelFromJson(json!);
  }

  factory ReciterModel.fromJson(Map<String, dynamic> json) =>
      _$ReciterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReciterModelToJson(this);

  @override
  ReciterEntity toEntity() {
    return ReciterEntity(
      id: id,
      name: name?.toEntity(),
      image: image,
      numberOfKhatmat: numberOfKhatmat ?? 0,
      bio: bio?.toEntity(),
    );
  }
}
