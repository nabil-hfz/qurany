// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecitationFilterModel _$RecitationFilterModelFromJson(Map json) =>
    RecitationFilterModel(
      reciterId: json['reciterId'] as int?,
      khatmaId: json['khatmaId'] as int?,
    )
      ..sort = json['sort'] == null
          ? null
          : BaseSortModel.fromJson(
              Map<String, dynamic>.from(json['sort'] as Map))
      ..limit = json['limit'] as int
      ..page = json['page'] as int;

Map<String, dynamic> _$RecitationFilterModelToJson(
    RecitationFilterModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sort', instance.sort);
  val['limit'] = instance.limit;
  val['page'] = instance.page;
  writeNotNull('reciterId', instance.reciterId);
  writeNotNull('khatmaId', instance.khatmaId);
  return val;
}
