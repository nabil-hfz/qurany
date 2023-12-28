import 'package:kawtharuna/src/core/entity/base/base_entity.dart';
import 'package:kawtharuna/src/core/models/localization/localized_model.dart';

class LocalizedEntity extends BaseEntity {
  final String? ar;
  final String? en;

  const LocalizedEntity({
    this.ar,
    this.en,
  });

  LocalizedModel toModel() {
    return LocalizedModel(
      ar: ar,
      en: en,
    );
  }

  @override
  List<Object?> get props => [
        ar,
        en,
      ];
}
