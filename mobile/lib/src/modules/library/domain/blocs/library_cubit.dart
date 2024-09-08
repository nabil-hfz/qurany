import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/bloc/base/base_cubit.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_init_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_loading_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_success_state.dart';
import 'package:kawtharuna/src/core/widgets/common/refresh_wrapper.dart';
import 'package:kawtharuna/src/modules/library/data/models/library_filter_model.dart';
import 'package:kawtharuna/src/modules/library/domain/entity/library_entity.dart';
import 'package:kawtharuna/src/modules/library/domain/repo/library_repository_impl.dart';

part 'library_state.dart';

@Singleton()
class LibraryCubit extends BaseCubit<LibraryState> {
  late final ImplLibraryRepository _repository;

  final List<FileEntryEntity> _fileEntries = [];
  late LibraryFilterModel _libraryFilter;

  LibraryCubit(this._repository) : super(LibraryState.initialState()) {
    // _LibraryFileEntriesFilter = FileEntryFilterModel();
    // _categorizedLibraryFileEntriesFilter = FileEntryFilterModel();
    _libraryFilter = LibraryFilterModel(
        // orders: ordersDesc,
        // withDefaultOrder: false,
        // fromDate: dateTimeNow,
        // fromSelectedDateTime: dateTimeNow,
        );
  }

  Future<void> getLibraryFileEntries({
    CancelToken? cancelToken,
    RefreshControllerHandler? controller,
    bool isRefresh = false,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(getLibraryFileEntries: const BaseLoadingState()));
      _libraryFilter.page = 1;
    }

    final result = await _repository.getLibraryFileEntries(
      cancelToken: cancelToken,
      filter: _libraryFilter,
    );

    controller?.handleList(result.data?.items, pageIndex: _libraryFilter.page);

    if (result.hasDataOnly) {
      _libraryFilter.page++;
      if (isRefresh) _fileEntries.clear();
      if (result.data?.items != null) _fileEntries.addAll(result.data!.items);
      emit(
        state.copyWith(
          getLibraryFileEntries:
              LibraryFileEntriesSuccess(fileEntries: _fileEntries),
        ),
      );
    } else {
      emit(
        state.copyWith(
          getLibraryFileEntries: BaseFailState(
            result.error,
            callback: () {
              getLibraryFileEntries(
                cancelToken: cancelToken,
                controller: controller,
                isRefresh: isRefresh,
              );
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

  Future<void> increaseFileViewCount({
    required FileEntryEntity file,
    bool isRefresh = false,
    CancelToken? cancelToken,
  }) async {
    if (isRefresh) {
      emit(state.copyWith(increaseFileViewCount: const BaseLoadingState()));
    }
    final result = await _repository.increaseFileViewsCount(
      cancelToken: cancelToken,
      fileId: file.id,
    );

    if (result.hasDataOnly) {
      int index =
          _fileEntries.indexWhere((fileEntry) => fileEntry.id == file.id);
      if (index >= 0) {
        if (result.data != null) {
          _fileEntries[index] = result.data!;
        } else {
          _fileEntries[index] = file.copyWith(totalViews: file.totalViews + 1);
        }
      }
      emit(
        state.copyWith(
          getLibraryFileEntries:
              LibraryFileEntriesSuccess(fileEntries: _fileEntries),
        ),
      );

      emit(state.copyWith(increaseFileViewCount: BaseSuccessState()));
    } else {
      emit(
        state.copyWith(
          increaseFileViewCount: BaseFailState(
            result.error,
            callback: () {
              increaseFileViewCount(
                file: file,
                isRefresh: isRefresh,
                cancelToken: cancelToken,
              );
            },
          ),
        ),
      );
    }
  }

  Future<void> increaseFileDownloadsCount({
    required FileEntryEntity file,
    bool isRefresh = false,
    CancelToken? cancelToken,
  }) async {
    if (isRefresh) {
      emit(
        state.copyWith(
          increaseFileDownloadsCount: const BaseLoadingState(),
        ),
      );
    }
    final result = await _repository.increaseFileDownloadsCount(
      cancelToken: cancelToken,
      fileId: file.id,
    );

    if (result.hasDataOnly) {
      int index =
          _fileEntries.indexWhere((fileEntry) => fileEntry.id == file.id);
      if (index >= 0) {
        if (result.data != null) {
          _fileEntries[index] = result.data!;
        } else {
          _fileEntries[index] =
              file.copyWith(totalDownloads: file.totalDownloads + 1);
        }
      }
      emit(
        state.copyWith(
          getLibraryFileEntries:
              LibraryFileEntriesSuccess(fileEntries: _fileEntries),
        ),
      );

      emit(state.copyWith(increaseFileDownloadsCount: BaseSuccessState()));
    } else {
      emit(
        state.copyWith(
          increaseFileDownloadsCount: BaseFailState(
            result.error,
            callback: () {
              increaseFileDownloadsCount(
                file: file,
                isRefresh: isRefresh,
                cancelToken: cancelToken,
              );
            },
          ),
        ),
      );
    }
  }

  @override
  void emit(LibraryState state) {
    super.emit(state);
    // log('$FileEntryCubit emits a $state state');
  }
}
