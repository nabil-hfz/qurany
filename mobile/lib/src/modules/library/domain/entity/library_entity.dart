import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/core/entity/localization/localized_entity.dart';
import 'package:kawtharuna/src/modules/reciter/domain/entity/reciter_entity.dart';

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
  final LocalizedEntity? name;
  final ReciterEntity? reciter;

  const FileEntryEntity({
    required this.id,
    this.name,
    this.reciter,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        reciter,
      ];
}
