// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KhatmatListModel _$KhatmatListModelFromJson(Map json) => KhatmatListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => KhatmaModel.fromJson(e as Map))
          .toList(),
    );

Map<String, dynamic> _$KhatmatListModelToJson(KhatmatListModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

KhatmaModel _$KhatmaModelFromJson(Map json) => KhatmaModel(
      id: json['id'] as int,
      name: json['name'] == null
          ? null
          : LocalizedModel.fromJson(
              Map<String, dynamic>.from(json['name'] as Map)),
      image: json['image'] as String?,
      numberOfKhatmat: json['numberOfKhatmat'] as int?,
      bio: json['bio'] == null
          ? null
          : LocalizedModel.fromJson(
              Map<String, dynamic>.from(json['bio'] as Map)),
    );

Map<String, dynamic> _$KhatmaModelToJson(KhatmaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'numberOfKhatmat': instance.numberOfKhatmat,
      'bio': instance.bio,
    };
