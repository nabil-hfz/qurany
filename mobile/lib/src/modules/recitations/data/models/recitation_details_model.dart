import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/localization/localized_model.dart';
import 'package:kawtharuna/src/modules/recitations/data/models/recitation_model.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_details_entity.dart';

part 'recitation_details_model.g.dart';

@JsonSerializable(anyMap: true)
class RecitationDetailsModel extends RecitationModel {
  final int? audioFileSizeInByte;
  final int? totalDownloads;
  final int? totalPlays;
  final DateTime? createdAt;

  RecitationDetailsModel({
    super.id,
    super.khatmaId,
    super.title,
    super.audio,
    super.image,
    super.durationInMilli,
    this.audioFileSizeInByte,
    this.totalDownloads,
    this.totalPlays,
    this.createdAt,
  });

  factory RecitationDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$RecitationDetailsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecitationDetailsModelToJson(this);

  @override
  RecitationDetailsEntity toEntity() {
    return RecitationDetailsEntity(
      id: super.id ?? -1,
      khatmaId: super.khatmaId ?? -1,
      title: title?.toEntity(),
      audio: audio,
      image: image,
      durationInSecond: super.durationInMilli ?? 0,
      audioFileSizeInByte: audioFileSizeInByte ?? 0,
      totalDownloads: totalDownloads ?? 0,
      totalPlays: totalPlays ?? 0,
      createdAt: createdAt,
    );
  }
}
