part of 'recitation_cubit.dart';

class RecitationState {
  const RecitationState({
    required this.getRecitations,
    required this.getRecitation,
  });

  final BaseState getRecitations;
  final BaseState getRecitation;

  factory RecitationState.initialState() => const RecitationState(
        getRecitations: BaseInitState(),
        getRecitation: BaseInitState(),
      );

  RecitationState copyWith({
    BaseState? getRecitations,
    BaseState? getRecitation,
  }) {
    return RecitationState(
      getRecitations: getRecitations ?? this.getRecitations,
      getRecitation: getRecitation ?? this.getRecitation,
    );
  }

  @override
  String toString() {
    return '$RecitationState('
        'getRecitations: $getRecitations, '
        'getRecitation: $getRecitation'
        ')';
  }
}

class RecitationsSuccess extends BaseSuccessState {
  final List<RecitationEntity> recitations;

  const RecitationsSuccess({required this.recitations});

  @override
  List<Object> get props => [recitations];

  @override
  String toString() => '$RecitationsSuccess(recitations: $recitations)';
}

class RecitationSuccess extends BaseSuccessState {
  final RecitationEntity recitation;

  const RecitationSuccess({required this.recitation});

  @override
  List<Object> get props => [recitation];

  @override
  String toString() => '$RecitationSuccess(recitation: $recitation)';
}
