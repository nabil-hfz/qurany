import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/bloc/base/base_cubit.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_init_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_loading_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_success_state.dart';
import 'package:kawtharuna/src/modules/library/domain/entity/library_entity.dart';
import 'package:kawtharuna/src/modules/library/domain/repo/library_repository_impl.dart';

part 'library_state.dart';

@Singleton()
class FileEntryCubit extends BaseCubit<FileEntryState> {
  late final ImplLibraryRepository _repository;

  final List<FileEntryEntity> _fileEntries = [];

  FileEntryCubit(this._repository) : super(FileEntryState.initialState()) {
    // _LibraryFileEntriesFilter = FileEntryFilterModel();
    // _categorizedLibraryFileEntriesFilter = FileEntryFilterModel();
  }

  Future<void> getLibraryFileEntries({
    CancelToken? cancelToken,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(getLibraryFileEntries: const BaseLoadingState()));
    }
    final results = await _repository.getLibraryFileEntries(
      cancelToken: cancelToken,
    );

    if (results.hasDataOnly) {
      if (isRefresh) _fileEntries.clear();
      if (results.data?.items != null) _fileEntries.addAll(results.data!.items);
      emit(state.copyWith(
          getLibraryFileEntries: LibraryFileEntriesSuccess(
        fileEntries: _fileEntries,
      )));
    } else {
      emit(
        state.copyWith(
          getLibraryFileEntries: BaseFailState(
            results.error,
            callback: () {
              getLibraryFileEntries(cancelToken: cancelToken);
            },
          ),
        ),
      );
    }
  }

  Future<void> getFileEntry({
    required String id,
    bool isRefresh = false,
    CancelToken? cancelToken,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(getFileEntry: const BaseLoadingState()));
    }
    final result = await _repository.getFileEntry(
      cancelToken: cancelToken,
      id: id,
    );

    if (result.hasDataOnly) {
      emit(
          state.copyWith(getFileEntry: FileEntrySuccess(khatma: result.data!)));
    } else {
      emit(
        state.copyWith(
          getFileEntry: BaseFailState(
            result.error,
            callback: () {
              getFileEntry(cancelToken: cancelToken, id: id);
            },
          ),
        ),
      );
    }
  }

  @override
  void emit(FileEntryState state) {
    super.emit(state);
    // log('$FileEntryCubit emits a $state state');
  }
}
