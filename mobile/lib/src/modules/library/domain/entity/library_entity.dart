import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';

class LibraryListEntity extends BaseEntity {
  final List<FileEntryEntity> items;

  const LibraryListEntity({required this.items});

  @override
  List<Object?> get props => [
        items,
      ];
}

class FileEntryEntity extends BaseEntity {
  final int id;
  final String? name;
  final LibraryLanguageEntity? language;
  final String? file;
  final String? thumbnail;
  final int totalViews;
  final int totalDownloads;
  final List<LibraryCategoryEntity>? categories;

  const FileEntryEntity({
    required this.id,
    this.name,
    this.language,
    this.file,
    this.thumbnail,
    required this.totalViews,
    required this.totalDownloads,
    this.categories,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        language,
        file,
        thumbnail,
        totalViews,
        totalDownloads,
        categories,
      ];

  @override
  FileEntryEntity copyWith({
    int? id,
    String? name,
    LibraryLanguageEntity? language,
    String? file,
    String? thumbnail,
    int? totalViews,
    int? totalDownloads,
    List<LibraryCategoryEntity>? categories,
  }) {
    return FileEntryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      language: language ?? this.language,
      file: file ?? this.file,
      thumbnail: thumbnail ?? this.thumbnail,
      totalViews: totalViews ?? this.totalViews,
      totalDownloads: totalDownloads ?? this.totalDownloads,
      categories: categories ?? this.categories,
    );
  }
}

class LibraryCategoryEntity extends BaseEntity {
  final int id;
  final LocalizedEntity? name;

  const LibraryCategoryEntity({
    required this.id,
    this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

class LibraryLanguageEntity extends BaseEntity {
  final int id;
  final String? name;

  const LibraryLanguageEntity({
    required this.id,
    this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
