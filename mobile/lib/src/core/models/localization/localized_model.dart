import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';

part 'localized_model.g.dart';

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
