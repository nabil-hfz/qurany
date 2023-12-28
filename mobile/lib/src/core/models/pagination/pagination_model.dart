import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(anyMap: true)
class PaginationModel {
  int page;
  int limit;

  PaginationModel({
    required this.page,
    this.limit = 10,
  });

  factory PaginationModel.defaultValues() {
    return PaginationModel(page: 1, limit: 10);
  }

  PaginationModel copyWith({
    int? page,
    int? pageSize,
  }) =>
      PaginationModel(
        page: page ?? this.page,
        limit: pageSize ?? limit,
      );

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  @override
  String toString() {
    return "PaginationModel("
        "page: $page, "
        "pageSize: $limit"
        ")";
  }
}
