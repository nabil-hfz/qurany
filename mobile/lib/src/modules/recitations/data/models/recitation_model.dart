import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';
import 'package:kawtharuna/src/core/models/localization/localized_model.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';

part 'recitation_model.g.dart';

@JsonSerializable(anyMap: true)
class RecitationsListModel extends BaseModel {
  final List<RecitationModel>? items;

  RecitationsListModel({
    this.items,
  });

  factory RecitationsListModel.fromJson(Map<String, dynamic> json) =>
      _$RecitationsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecitationsListModelToJson(this);

  @override
  RecitationsListEntity toEntity() {
    return RecitationsListEntity(
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

@JsonSerializable(anyMap: true)
class RecitationModel extends BaseModel<RecitationEntity> {
  final int? id;
  final int? khatmaId;
  final LocalizedModel? title;
  final String? audio;
  final String? image;
  final int? durationInSecond;

  RecitationModel({
    this.id,
    this.khatmaId,
    this.title,
    this.audio,
    this.image,
    this.durationInSecond,
  });

  factory RecitationModel.fromJson(Map<String, dynamic> json) =>
      _$RecitationModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecitationModelToJson(this);

  @override
  RecitationEntity toEntity() {
    return RecitationEntity(
      id: id ?? -1,
      khatmaId: khatmaId ?? -1,
      title: title?.toEntity(),
      audio: audio,
      image: image,
      durationInSecond: durationInSecond ?? 0,
    );
  }
}
