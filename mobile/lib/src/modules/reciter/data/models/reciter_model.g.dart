// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reciter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecitersListModel _$RecitersListModelFromJson(Map json) => RecitersListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => ReciterModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$RecitersListModelToJson(RecitersListModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

ReciterModel _$ReciterModelFromJson(Map json) => ReciterModel(
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

Map<String, dynamic> _$ReciterModelToJson(ReciterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'numberOfKhatmat': instance.numberOfKhatmat,
      'bio': instance.bio,
    };
