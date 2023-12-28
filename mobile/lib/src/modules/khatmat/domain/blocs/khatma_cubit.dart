import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/bloc/base/base_cubit.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_init_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_loading_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_success_state.dart';
import 'package:kawtharuna/src/modules/reciter/domain/entity/reciter_entity.dart';
import 'package:kawtharuna/src/modules/reciter/domain/repo/reciter_repository_impl.dart';

part 'khatma_state.dart';

@Singleton()
class ReciterCubit extends BaseCubit<ReciterState> {
  late final ImplReciterRepository _repository;

  final List<ReciterEntity> _reciters = [];

  ReciterCubit(this._repository) : super(ReciterState.initialState()) {
    // _RecitersFilter = ReciterFilterModel();
    // _categorizedRecitersFilter = ReciterFilterModel();
  }

  Future<void> getReciters({
    CancelToken? cancelToken,
    bool isRefresh = false,
  }) async {
    if (isRefresh) emit(state.copyWith(getReciters: const BaseLoadingState()));
    final results = await _repository.getReciters(
      cancelToken: cancelToken,
    );

    if (results.hasDataOnly) {
      if (isRefresh) _reciters.clear();
      if (results.data?.items != null) _reciters.addAll(results.data!.items);
      emit(state.copyWith(getReciters: RecitersSuccess(reciters: _reciters)));
    } else {
      emit(
        state.copyWith(
          getReciters: BaseFailState(
            results.error,
            callback: () {
              getReciters(cancelToken: cancelToken);
            },
          ),
        ),
      );
    }
  }

  Future<void> getReciter({
    required String id,
    bool isRefresh = false,
    CancelToken? cancelToken,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(getReciter: const BaseLoadingState()));
    }
    final result = await _repository.getReciter(
      cancelToken: cancelToken,
      id: id,
    );

    if (result.hasDataOnly) {
      emit(state.copyWith(getReciter: ReciterSuccess(reciter: result.data!)));
    } else {
      emit(
        state.copyWith(
          getReciter: BaseFailState(
            result.error,
            callback: () {
              getReciter(cancelToken: cancelToken, id: id);
            },
          ),
        ),
      );
    }
  }

  Future<void> createReciter({
    required ReciterEntity reciter,
    CancelToken? cancelToken,
  }) async {
    emit(state.copyWith(createReciter: const BaseLoadingState()));

    final result = await _repository.createReciter(
      cancelToken: cancelToken,
      reciter: reciter,
    );

    if (result.hasDataOnly) {
      emit(state.copyWith(createReciter: const BaseSuccessState()));
      emit(state.copyWith(createReciter: const BaseInitState()));
    } else {
      emit(
        state.copyWith(
          createReciter: BaseFailState(
            result.error,
            callback: () {
              createReciter(reciter: reciter, cancelToken: cancelToken);
            },
          ),
        ),
      );
    }
  }

  Future<void> deleteReciter({
    required String id,
    CancelToken? cancelToken,
  }) async {
    emit(state.copyWith(deleteReciter: BaseLoadingState(data: id)));

    final result = await _repository.deleteReciter(
      id: id,
      cancelToken: cancelToken,
    );

    if (result.hasDataOnly) {
      emit(state.copyWith(deleteReciter: const BaseSuccessState()));
      // for (var categorizedReciter in _categorizedReciter) {
      //   for (var Reciter in categorizedReciter.Reciters) {
      //     if (Reciter.id == id) {
      //       categorizedReciter.Reciters.remove(Reciter);
      //       break;
      //     }
      //   }
      // }
      // emit(
      //   state.copyWith(
      //     getCategorizedReciters: CategorizedRecitersSuccess(
      //       categorizedReciter: _categorizedReciter,
      //     ),
      //   ),
      // );
      emit(state.copyWith(deleteReciter: const BaseInitState()));
    } else {
      emit(
        state.copyWith(
          deleteReciter: BaseFailState(
            result.error,
            callback: () {
              deleteReciter(id: id, cancelToken: cancelToken);
            },
          ),
        ),
      );
    }
  }

  @override
  void emit(ReciterState state) {
    super.emit(state);
    log('ReciterBloc emits a $state state');
  }
}
