part of 'library_cubit.dart';

class KhatmaState {
  const KhatmaState({
    required this.getKhatmat,
    required this.getKhatma,
    required this.createKhatma,
    required this.updateKhatma,
    required this.deleteKhatma,
  });

  final BaseState getKhatmat;
  final BaseState getKhatma;
  final BaseState createKhatma;
  final BaseState updateKhatma;
  final BaseState deleteKhatma;

  factory KhatmaState.initialState() => const KhatmaState(
        getKhatmat: BaseInitState(),
        getKhatma: BaseInitState(),
        createKhatma: BaseInitState(),
        updateKhatma: BaseInitState(),
        deleteKhatma: BaseInitState(),
      );

  KhatmaState copyWith({
    BaseState? getKhatmat,
    BaseState? getKhatma,
    BaseState? createKhatma,
    BaseState? updateKhatma,
    BaseState? deleteKhatma,
  }) {
    return KhatmaState(
      getKhatmat: getKhatmat ?? this.getKhatmat,
      getKhatma: getKhatma ?? this.getKhatma,
      createKhatma: createKhatma ?? this.createKhatma,
      updateKhatma: updateKhatma ?? this.updateKhatma,
      deleteKhatma: deleteKhatma ?? this.deleteKhatma,
    );
  }

  @override
  String toString() {
    return '$KhatmaState('
        'getKhatmat: $getKhatmat, '
        'getKhatma: $getKhatma'
        'createKhatma: $createKhatma'
        'createKhatma: $createKhatma'
        'updateKhatma: $updateKhatma'
        'deleteKhatma: $deleteKhatma'
        ')';
  }
}

class KhatmatSuccess extends BaseSuccessState {
  final List<KhatmaEntity> khatmat;

  const KhatmatSuccess({required this.khatmat});

  @override
  List<Object> get props => [khatmat];

  @override
  String toString() => '$KhatmatSuccess(khatmat: $khatmat)';
}

class KhatmaSuccess extends BaseSuccessState {
  final KhatmaEntity khatma;

  const KhatmaSuccess({required this.khatma});

  @override
  List<Object> get props => [khatma];

  @override
  String toString() => '$KhatmaSuccess(khatma: $khatma)';
}
