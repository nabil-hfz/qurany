// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibraryListModel _$LibraryListModelFromJson(Map json) => LibraryListModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              FileEntryModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$LibraryListModelToJson(LibraryListModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

FileEntryModel _$FileEntryModelFromJson(Map json) => FileEntryModel(
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

Map<String, dynamic> _$FileEntryModelToJson(FileEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reciter': instance.reciter,
    };
