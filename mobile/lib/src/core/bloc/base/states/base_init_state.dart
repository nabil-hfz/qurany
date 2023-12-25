import 'package:kawtharuna/src/core/bloc/base/states/base_state.dart';

/// This is the initial state for all blocs in the application as
/// a standard state extends the base state class [BaseState].
class BaseInitState extends BaseState {
  /// Holding an optional data when first creating the bloc if any.
  final dynamic initialData;

  const BaseInitState({this.initialData});

  @override
  List<Object?> get props => [initialData];

  @override
  String toString() {
    return 'BaseInitState(initialData: $initialData)';
  }
}
