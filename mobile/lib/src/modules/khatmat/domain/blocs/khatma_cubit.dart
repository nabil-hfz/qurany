import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/bloc/base/base_cubit.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_init_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_loading_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_success_state.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/repo/khatma_repository_impl.dart';

part 'khatma_state.dart';

@Singleton()
class KhatmaCubit extends BaseCubit<KhatmaState> {
  late final ImplKhatmaRepository _repository;

  final List<KhatmaEntity> _khatmat = [];

  KhatmaCubit(this._repository) : super(KhatmaState.initialState()) {
    // _KhatmatFilter = KhatmaFilterModel();
    // _categorizedKhatmatFilter = KhatmaFilterModel();
  }

  Future<void> getKhatmat({
    CancelToken? cancelToken,
    bool isRefresh = false,
  }) async {
    if (isRefresh) emit(state.copyWith(getKhatmat: const BaseLoadingState()));
    final results = await _repository.getKhatmat(
      cancelToken: cancelToken,
    );

    if (results.hasDataOnly) {
      if (isRefresh) _khatmat.clear();
      if (results.data?.items != null) _khatmat.addAll(results.data!.items);
      emit(state.copyWith(getKhatmat: KhatmatSuccess(khatmat: _khatmat)));
    } else {
      emit(
        state.copyWith(
          getKhatmat: BaseFailState(
            results.error,
            callback: () {
              getKhatmat(cancelToken: cancelToken);
            },
          ),
        ),
      );
    }
  }

  Future<void> getKhatma({
    required String id,
    bool isRefresh = false,
    CancelToken? cancelToken,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(getKhatma: const BaseLoadingState()));
    }
    final result = await _repository.getKhatma(
      cancelToken: cancelToken,
      id: id,
    );

    if (result.hasDataOnly) {
      emit(state.copyWith(getKhatma: KhatmaSuccess(khatma: result.data!)));
    } else {
      emit(
        state.copyWith(
          getKhatma: BaseFailState(
            result.error,
            callback: () {
              getKhatma(cancelToken: cancelToken, id: id);
            },
          ),
        ),
      );
    }
  }

  @override
  void emit(KhatmaState state) {
    super.emit(state);
    // log('$KhatmaCubit emits a $state state');
  }
}
