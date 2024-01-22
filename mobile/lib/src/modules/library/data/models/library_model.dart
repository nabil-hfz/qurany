import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_model.dart';
import 'package:kawtharuna/src/core/models/localization/localized_model.dart';
import 'package:kawtharuna/src/modules/library/domain/entity/library_entity.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';

part 'library_model.g.dart';

@JsonSerializable(anyMap: true)
class LibraryListModel extends BaseModel {
  final List<FileEntryModel>? items;

  LibraryListModel({
    this.items,
  });

  factory LibraryListModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryListModelFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryListModelToJson(this);

  @override
  LibraryListEntity toEntity() {
    return LibraryListEntity(
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

@JsonSerializable(anyMap: true)
class FileEntryModel extends BaseModel<FileEntryEntity> {
  final int? id;
  final String? name;
  final LibraryLanguageModel? language;
  final String? file;
  final String? thumbnail;
  final int? totalViews;
  final int? totalDownloads;
  final List<LibraryCategoryModel>? categories;

  FileEntryModel({
    this.id,
    this.name,
    this.language,
    this.file,
    this.thumbnail,
    this.totalViews,
    this.totalDownloads,
    this.categories,
  });

  FileEntryModel copyWith({
    int? id,
    String? name,
    LibraryLanguageModel? language,
    String? file,
    String? thumbnail,
    int? totalViews,
    int? totalDownloads,
    List<LibraryCategoryModel>? categories,
  }) =>
      FileEntryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        language: language ?? this.language,
        file: file ?? this.file,
        thumbnail: thumbnail ?? this.thumbnail,
        totalViews: totalViews ?? this.totalViews,
        totalDownloads: totalDownloads ?? this.totalDownloads,
        categories: categories ?? this.categories,
      );

  factory FileEntryModel.fromJson(Map<String, dynamic> json) =>
      _$FileEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileEntryModelToJson(this);

  @override
  FileEntryEntity toEntity() {
    return FileEntryEntity(
      id: id ?? -1,
      name: name ?? '',
      language: language?.toEntity(),
      file: file ?? '',
      thumbnail: thumbnail ?? '',
      totalViews: totalViews ?? 0,
      totalDownloads: totalDownloads ?? 0,
      categories: categories?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

@JsonSerializable(anyMap: true)
class LibraryLanguageModel extends BaseModel<LibraryLanguageEntity> {
  final int? id;
  final String? name;

  LibraryLanguageModel({
    this.id,
    this.name,
  });

  LibraryLanguageModel copyWith({
    int? id,
    String? name,
  }) =>
      LibraryLanguageModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory LibraryLanguageModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryLanguageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryLanguageModelToJson(this);

  @override
  LibraryLanguageEntity toEntity() {
    return LibraryLanguageEntity(
      id: id ?? -1,
      name: name,
    );
  }
}

@JsonSerializable(anyMap: true)
class LibraryCategoryModel extends BaseModel<LibraryCategoryEntity> {
  final int? id;
  final LocalizedModel? name;

  LibraryCategoryModel({
    this.id,
    this.name,
  });

  LibraryCategoryModel copyWith({
    int? id,
    LocalizedModel? name,
  }) =>
      LibraryCategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory LibraryCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryCategoryModelToJson(this);

  @override
  LibraryCategoryEntity toEntity() {
    return LibraryCategoryEntity(
      id: id ?? -1,
      name: name?.toEntity(),
    );
  }
}
