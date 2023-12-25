import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable()
class PaginationModel {
  int page;
  int? pageSize;
  bool? isRefresh;

  PaginationModel({
    required this.page,
    this.pageSize,
    this.isRefresh = true,
  });

  factory PaginationModel.defaultValues() {
    return PaginationModel(page: 0, pageSize: 10);
  }

  PaginationModel copyWith({
    int? page,
    int? pageSize,
    bool? isRefresh,
  }) =>
      PaginationModel(
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        isRefresh: isRefresh ?? this.isRefresh,
      );

  /// This method should take a list of items and return paginated list.
  List<T> getPage<T>(List<T> list) {
    final end = list.length - 1;
    final start = page * pageSize!;
    if (start > end) return [];
    return list.sublist(page * pageSize!).take(pageSize!).toList();
  }

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  @override
  String toString() {
    return "PaginationModel(page: $page, pageSize: $pageSize, isRefresh: $isRefresh)";
  }
}
