import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_sort_model.dart';

import '../pagination/pagination_model.dart';

part 'base_filter.g.dart';

@JsonSerializable(anyMap: true, includeIfNull: false)
class BaseFilter extends Equatable {
  BaseSortModel? sort;
  final PaginationModel _pagination;

  BaseFilter(this.sort, this._pagination);

  factory BaseFilter.fromJson(Map<String, dynamic> json) =>
      _$BaseFilterFromJson(json);

  Map<String, dynamic> toJson() => _$BaseFilterToJson(this);

  int get limit {
    return _pagination.limit;
  }

  set limit(int value) {
    _pagination.limit = value;
  }

  int get page {
    return _pagination.page;
  }

  set page(int value) {
    _pagination.page = value;
  }

  @override
  List<Object?> get props => [
        sort,
        _pagination,
      ];

  @override
  String toString() {
    return "$BaseFilter($BaseSortModel: $sort, "
        "$PaginationModel: $_pagination"
        ")";
  }
}
