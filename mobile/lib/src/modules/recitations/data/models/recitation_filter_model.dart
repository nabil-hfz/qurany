import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/base/base_sort_model.dart';
import 'package:kawtharuna/src/core/models/pagination/pagination_model.dart';

part 'recitation_filter_model.g.dart';

@JsonSerializable(anyMap: true, includeIfNull: false)
class RecitationFilterModel extends BaseFilter {
  int? reciterId;
  int? khatmaId;

  RecitationFilterModel({
    this.reciterId,
    this.khatmaId,
  }) : super(
          BaseSortModel(),
          PaginationModel.defaultValues(),
        );

  factory RecitationFilterModel.fromJson(Map<String, dynamic> json) =>
      _$RecitationFilterModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RecitationFilterModelToJson(this);

  @override
  String toString() {
    return "$RecitationFilterModel(${toJson()}";
  }
}
