// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LibraryFilterModel _$LibraryFilterModelFromJson(Map json) =>
    LibraryFilterModel()
      ..sort = json['sort'] == null
          ? null
          : BaseSortModel.fromJson(
              Map<String, dynamic>.from(json['sort'] as Map))
      ..limit = json['limit'] as int
      ..page = json['page'] as int;

Map<String, dynamic> _$LibraryFilterModelToJson(LibraryFilterModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sort', instance.sort?.toJson());
  val['limit'] = instance.limit;
  val['page'] = instance.page;
  return val;
}
