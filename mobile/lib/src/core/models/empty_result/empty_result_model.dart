import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/entity/base/empty_result_entity.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';

part 'empty_result_model.g.dart';

@JsonSerializable()
class EmptyResultModel extends BaseModel<EmptyResultEntity> {
  final String? message;

  EmptyResultModel({this.message});

  factory EmptyResultModel.fromJson(Map<String, dynamic> json) =>
      _$EmptyResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyResultModelToJson(this);

  @override
  String toString() {
    return "EmptyResultModel(message: $message)";
  }

  @override
  EmptyResultEntity toEntity() {
    return EmptyResultEntity(
      message: message ?? '',
    );
  }
}
