import 'base_state.dart';

/// This is the loading state for all blocs in the application as
/// a standard state extends the base state class [BaseState].
class BaseLoadingState extends BaseState {
  /// Holding an optional message requesting or processing.
  final String? message;

  /// Holding an optional data when requesting or processing.
  final dynamic data;

  const BaseLoadingState({this.message, this.data});

  @override
  List<Object?> get props => [message, data];

  @override
  String toString() {
    return 'BaseLoadingState(message: $message, data: $data)';
  }
}
