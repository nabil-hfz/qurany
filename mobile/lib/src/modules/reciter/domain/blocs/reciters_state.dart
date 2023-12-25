part of 'reciters_cubit.dart';

class ReciterState {
  const ReciterState({
    required this.getReciters,
    required this.getReciter,
    required this.createReciter,
    required this.updateReciter,
    required this.deleteReciter,
  });

  final BaseState getReciters;
  final BaseState getReciter;
  final BaseState createReciter;
  final BaseState updateReciter;
  final BaseState deleteReciter;

  factory ReciterState.initialState() => const ReciterState(
        getReciters: BaseInitState(),
        getReciter: BaseInitState(),
        createReciter: BaseInitState(),
        updateReciter: BaseInitState(),
        deleteReciter: BaseInitState(),
      );

  ReciterState copyWith({
    BaseState? getReciters,
    BaseState? getReciter,
    BaseState? createReciter,
    BaseState? updateReciter,
    BaseState? deleteReciter,
  }) {
    return ReciterState(
      getReciters: getReciters ?? this.getReciters,
      getReciter: getReciter ?? this.getReciter,
      createReciter: createReciter ?? this.createReciter,
      updateReciter: updateReciter ?? this.updateReciter,
      deleteReciter: deleteReciter ?? this.deleteReciter,
    );
  }

  @override
  String toString() {
    return '$ReciterState('
        'getReciters: $getReciters, '
        'getReciter: $getReciter'
        'createReciter: $createReciter'
        'createReciter: $createReciter'
        'updateReciter: $updateReciter'
        'deleteReciter: $deleteReciter'
        ')';
  }
}

class RecitersSuccess extends BaseSuccessState {
  final List<ReciterEntity> reciters;

  const RecitersSuccess({required this.reciters});

  @override
  List<Object> get props => [reciters];

  @override
  String toString() => 'RecitersSuccess(reciters: $reciters)';
}

class ReciterSuccess extends BaseSuccessState {
  final ReciterEntity reciter;

  const ReciterSuccess({required this.reciter});

  @override
  List<Object> get props => [reciter];

  @override
  String toString() => 'ReciterSuccess(reciter: $reciter)';
}
