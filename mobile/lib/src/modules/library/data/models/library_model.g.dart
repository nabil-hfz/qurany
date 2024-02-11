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
      name: json['name'] as String?,
      language: json['language'] == null
          ? null
          : LibraryLanguageModel.fromJson(
              Map<String, dynamic>.from(json['language'] as Map)),
      file: json['file'] as String?,
      thumbnail: json['thumbnail'] as String?,
      totalViews: json['totalViews'] as int?,
      totalDownloads: json['totalDownloads'] as int?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => LibraryCategoryModel.fromJson(
              Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$FileEntryModelToJson(FileEntryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'language': instance.language,
      'file': instance.file,
      'thumbnail': instance.thumbnail,
      'totalViews': instance.totalViews,
      'totalDownloads': instance.totalDownloads,
      'categories': instance.categories,
    };

LibraryLanguageModel _$LibraryLanguageModelFromJson(Map json) =>
    LibraryLanguageModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LibraryLanguageModelToJson(
        LibraryLanguageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

LibraryCategoryModel _$LibraryCategoryModelFromJson(Map json) =>
    LibraryCategoryModel(
      id: json['id'] as int?,
      name: json['name'] == null
          ? null
          : LocalizedModel.fromJson(
              Map<String, dynamic>.from(json['name'] as Map)),
    );

Map<String, dynamic> _$LibraryCategoryModelToJson(
        LibraryCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
