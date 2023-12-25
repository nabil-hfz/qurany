import 'package:equatable/equatable.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_success_state.dart';

/// This is a base state bloc. We use this [BaseState] to be as a super class
/// for all four possible derived states. See [BaseInitState], [BaseLoadingState]
/// [BaseSuccessState] and [BaseFailState].
abstract class BaseState extends Equatable {
  const BaseState();
}
