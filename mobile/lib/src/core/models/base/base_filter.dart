import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kawtharuna/src/core/models/base/base_sort_model.dart';

import '../pagination/pagination_model.dart';

part 'base_filter.g.dart';

@JsonSerializable(anyMap: true, includeIfNull: false)
class BaseFilter extends Equatable {
  BaseSortModel? sort;
  final PaginationModel pagination;

  BaseFilter(this.sort, this.pagination);

  factory BaseFilter.fromJson(Map<String, dynamic> json) =>
      _$BaseFilterFromJson(json);

  Map<String, dynamic> toJson() => _$BaseFilterToJson(this);

  int get limit {
    return pagination.limit;
  }

  set limit(int value) {
    pagination.limit = value;
  }

  int get page {
    return pagination.page;
  }

  set page(int value) {
    pagination.page = value;
  }

  @override
  List<Object?> get props => [
        sort,
        pagination,
      ];

  @override
  String toString() {
    return "$BaseFilter($BaseSortModel: $sort, "
        "$PaginationModel: $pagination"
        ")";
  }
}
