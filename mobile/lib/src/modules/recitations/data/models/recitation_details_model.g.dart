// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecitationDetailsModel _$RecitationDetailsModelFromJson(Map json) =>
    RecitationDetailsModel(
      id: json['id'] as int?,
      khatmaId: json['khatmaId'] as int?,
      title: json['title'] == null
          ? null
          : LocalizedModel.fromJson(
              Map<String, dynamic>.from(json['title'] as Map)),
      audio: json['audio'] as String?,
      image: json['image'] as String?,
      durationInSecond: json['durationInSecond'] as int?,
      audioFileSizeInByte: json['audioFileSizeInByte'] as int?,
      totalDownloads: json['totalDownloads'] as int?,
      totalPlays: json['totalPlays'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecitationDetailsModelToJson(
        RecitationDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'khatmaId': instance.khatmaId,
      'title': instance.title,
      'audio': instance.audio,
      'image': instance.image,
      'durationInSecond': instance.durationInSecond,
      'audioFileSizeInByte': instance.audioFileSizeInByte,
      'totalDownloads': instance.totalDownloads,
      'totalPlays': instance.totalPlays,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
