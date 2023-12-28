import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_sort_model.g.dart';

@JsonSerializable(anyMap: true, includeIfNull: false)
class BaseSortModel extends Equatable {
  const BaseSortModel();

  factory BaseSortModel.fromJson(Map<String, dynamic> json) =>
      _$BaseSortModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseSortModelToJson(this);

  @override
  List<Object?> get props => [];
}
