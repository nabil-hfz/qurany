// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recitation_filter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************
RecitationFilterModel _$RecitationFilterModelFromJson(
    Map<String, dynamic> json) {
  return RecitationFilterModel(
    reciterId: json['reciterId'] as int?,
    khatmaId: json['khatmaId'] as int?,
  )
    ..sort = BaseSortModel.fromJson(json['sort'] as Map<String, dynamic>)
    ..limit = json['limit'] as int
    ..page = json['page'] as int;
}

Map<String, dynamic> _$RecitationFilterModelToJson(
    RecitationFilterModel instance) {
  final val = <String, dynamic>{
    'reciterId': instance.reciterId,
    'khatmaId': instance.khatmaId,
  };

  val['sort'] = instance.sort?.toJson();
  val['limit'] = instance.limit;
  val['page'] = instance.page;

  return val;
}
