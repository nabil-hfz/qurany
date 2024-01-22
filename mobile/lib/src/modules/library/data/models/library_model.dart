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
  final LocalizedModel? name;
  final ReciterModel? reciter;

  FileEntryModel({
    this.id,
    this.name,
    this.reciter,
  });

  factory FileEntryModel.fromJson(Map<String, dynamic> json) =>
      _$FileEntryModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileEntryModelToJson(this);

  @override
  FileEntryEntity toEntity() {
    return FileEntryEntity(
      id: id ?? -1,
      name: name?.toEntity(),
      reciter: reciter?.toEntity(),
    );
  }
}
