import 'package:equatable/equatable.dart';
import 'package:kawtharuna/src/core/models/base/base_sort_model.dart';

import '../pagination/pagination_model.dart';

abstract class BaseFilter extends Equatable {
  final BaseSortModel sort;
  final PaginationModel pagination;

  const BaseFilter(this.sort, this.pagination);

  @override
  List<Object?> get props => [
        sort,
        pagination,
      ];

  @override
  String toString() {
    return "BaseFilter(BaseSortModel: $sort, PaginationModel: $pagination)";
  }
}
