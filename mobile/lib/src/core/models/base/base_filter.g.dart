// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_filter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseFilter _$BaseFilterFromJson(Map json) => BaseFilter(
      BaseSortModel.fromJson(Map<String, dynamic>.from(json['sort'] as Map)),
      PaginationModel.fromJson(
          Map<String, dynamic>.from(json['pagination'] as Map)),
    );

Map<String, dynamic> _$BaseFilterToJson(BaseFilter instance) =>
    <String, dynamic>{
      'sort': instance.sort,
      'pagination': instance._pagination,
    };
