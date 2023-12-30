// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseFilter _$BaseFilterFromJson(Map json) => BaseFilter(
      json['sort'] == null
          ? null
          : BaseSortModel.fromJson(
              Map<String, dynamic>.from(json['sort'] as Map)),
      PaginationModel.fromJson(
          Map<String, dynamic>.from(json['pagination'] as Map)),
    )
      ..limit = json['limit'] as int
      ..page = json['page'] as int;

Map<String, dynamic> _$BaseFilterToJson(BaseFilter instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sort', instance.sort);
  val['pagination'] = instance.pagination;
  val['limit'] = instance.limit;
  val['page'] = instance.page;
  return val;
}
