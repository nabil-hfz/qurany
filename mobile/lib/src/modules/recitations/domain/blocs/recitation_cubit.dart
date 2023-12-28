import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/bloc/base/base_cubit.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_init_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_loading_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_success_state.dart';
import 'package:kawtharuna/src/modules/recitations/data/models/recitation_filter_model.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';
import 'package:kawtharuna/src/modules/recitations/domain/repo/recitation_repository_impl.dart';

part 'recitation_state.dart';

@Singleton()
class RecitationCubit extends BaseCubit<RecitationState> {
  late final ImplRecitationRepository _repository;
  late RecitationFilterModel _recitationsFilter;
  final List<RecitationEntity> _recitations = [];

  RecitationCubit(this._repository) : super(RecitationState.initialState()) {
    _recitationsFilter = RecitationFilterModel();
    _recitationsFilter.limit = 30;
    // _recitationsFilter.pagination.page =
    // _categorizedRecitationsFilter = RecitationFilterModel();
  }

  Future<void> getRecitations({
    CancelToken? cancelToken,
    bool isRefresh = false,
    int? reciterId,
    int? khatmaId,
  }) async {
    _recitationsFilter.reciterId = reciterId;
    _recitationsFilter.khatmaId = khatmaId;

    if (isRefresh) {
      emit(state.copyWith(getRecitations: const BaseLoadingState()));
    }

    final results = await _repository.getRecitations(
      cancelToken: cancelToken,
      filter: _recitationsFilter,
    );

    if (results.hasDataOnly) {
      if (isRefresh) _recitations.clear();
      if (results.data?.items != null) _recitations.addAll(results.data!.items);
      emit(
        state.copyWith(
          getRecitations: RecitationsSuccess(recitations: _recitations),
        ),
      );
    } else {
      emit(
        state.copyWith(
          getRecitations: BaseFailState(
            results.error,
            callback: () {
              getRecitations(
                cancelToken: cancelToken,
                khatmaId: khatmaId,
                isRefresh: isRefresh,
                reciterId: reciterId,
              );
            },
          ),
        ),
      );
    }
  }

  Future<void> getRecitation({
    required String id,
    bool isRefresh = false,
    CancelToken? cancelToken,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(getRecitation: const BaseLoadingState()));
    }
    final result = await _repository.getRecitation(
      cancelToken: cancelToken,
      id: id,
    );

    if (result.hasDataOnly) {
      emit(state.copyWith(
          getRecitation: RecitationSuccess(recitation: result.data!)));
    } else {
      emit(
        state.copyWith(
          getRecitation: BaseFailState(
            result.error,
            callback: () {
              getRecitation(cancelToken: cancelToken, id: id);
            },
          ),
        ),
      );
    }
  }

  @override
  void emit(RecitationState state) {
    super.emit(state);
    // log('$RecitationCubit emits a $state state');
  }
}
