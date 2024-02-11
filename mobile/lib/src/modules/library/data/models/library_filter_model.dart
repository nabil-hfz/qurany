import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_filter.dart';
import 'package:kawtharuna/src/core/models/base/base_sort_model.dart';
import 'package:kawtharuna/src/core/models/pagination/pagination_model.dart';

part 'library_filter_model.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true, includeIfNull: false)
class LibraryFilterModel extends BaseFilter {
  LibraryFilterModel()
      : super(BaseSortModel(), PaginationModel.defaultValues());

  factory LibraryFilterModel.fromJson(Map<String, dynamic> json) =>
      _$LibraryFilterModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LibraryFilterModelToJson(this);

  @override
  String toString() {
    return "$LibraryFilterModel(${toJson()}";
  }
}
