// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReciterModel _$ReciterModelFromJson(Map json) => ReciterModel(
      id: ReferenceIdConverter.fromJson(json['id']),
      createdDate: ServerTimestampConverter.fromJson(json['createdDate']),
      image: json['image'] as String?,
      name: json['name'] == null
          ? null
          : LocalizedModel.fromJson(
              Map<String, dynamic>.from(json['name'] as Map)),
      numberOfSeals: json['numberOfSeals'] as int?,
      bio: json['bio'] == null
          ? null
          : LocalizedModel.fromJson(
              Map<String, dynamic>.from(json['bio'] as Map)),
      totalNumberOfPlay: json['totalNumberOfPlay'] as int?,
      totalNumberOfDownload: json['totalNumberOfDownload'] as int?,
    );

Map<String, dynamic> _$ReciterModelToJson(ReciterModel instance) =>
    <String, dynamic>{
      'id': ReferenceIdConverter.toJson(instance.id),
      'createdDate': ServerTimestampConverter.toJson(instance.createdDate),
      'image': instance.image,
      'name': instance.name?.toJson(),
      'numberOfSeals': instance.numberOfSeals,
      'bio': instance.bio?.toJson(),
      'totalNumberOfPlay': instance.totalNumberOfPlay,
      'totalNumberOfDownload': instance.totalNumberOfDownload,
    };

LocalizedModel _$LocalizedModelFromJson(Map json) => LocalizedModel(
      ar: json['ar'] as String?,
      en: json['en'] as String?,
    );

Map<String, dynamic> _$LocalizedModelToJson(LocalizedModel instance) =>
    <String, dynamic>{
      'ar': instance.ar,
      'en': instance.en,
    };
