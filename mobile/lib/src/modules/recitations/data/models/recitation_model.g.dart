// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecitationsListModel _$RecitationsListModelFromJson(Map json) =>
    RecitationsListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              RecitationModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$RecitationsListModelToJson(
        RecitationsListModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

RecitationModel _$RecitationModelFromJson(Map json) => RecitationModel(
      id: json['id'] as int?,
      khatmaId: json['khatmaId'] as int?,
      title: json['title'] == null
          ? null
          : LocalizedModel.fromJson(
              Map<String, dynamic>.from(json['title'] as Map)),
      audio: json['audio'] as String?,
      image: json['image'] as String?,
      durationInSecond: json['durationInSecond'] as int?,
    );

Map<String, dynamic> _$RecitationModelToJson(RecitationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'khatmaId': instance.khatmaId,
      'title': instance.title,
      'audio': instance.audio,
      'image': instance.image,
      'durationInSecond': instance.durationInSecond,
    };
