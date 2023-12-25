import 'package:kawtharuna/src/core/entity/base/base_entity.dart';

class EmptyResultEntity extends BaseEntity {
  final String message;

  const EmptyResultEntity({required this.message});

  @override
  List<Object?> get props => [
        message,
      ];
}
