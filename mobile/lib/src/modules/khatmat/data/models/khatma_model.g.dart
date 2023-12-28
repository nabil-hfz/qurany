// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'khatma_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KhatmatListModel _$KhatmatListModelFromJson(Map json) => KhatmatListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map(
              (e) => KhatmaModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$KhatmatListModelToJson(KhatmatListModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

KhatmaModel _$KhatmaModelFromJson(Map json) => KhatmaModel(
      id: json['id'] as int?,
      name: json['name'] == null
          ? null
          : LocalizedModel.fromJson(
              Map<String, dynamic>.from(json['name'] as Map)),
      reciter: json['reciter'] == null
          ? null
          : ReciterModel.fromJson(
              Map<String, dynamic>.from(json['reciter'] as Map)),
    );

Map<String, dynamic> _$KhatmaModelToJson(KhatmaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reciter': instance.reciter,
    };
