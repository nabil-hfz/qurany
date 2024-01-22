part of 'library_cubit.dart';

class FileEntryState {
  const FileEntryState({
    required this.getLibraryFileEntries,
    required this.getFileEntry,
    required this.createFileEntry,
    required this.updateFileEntry,
    required this.deleteFileEntry,
  });

  final BaseState getLibraryFileEntries;
  final BaseState getFileEntry;
  final BaseState createFileEntry;
  final BaseState updateFileEntry;
  final BaseState deleteFileEntry;

  factory FileEntryState.initialState() => const FileEntryState(
        getLibraryFileEntries: BaseInitState(),
        getFileEntry: BaseInitState(),
        createFileEntry: BaseInitState(),
        updateFileEntry: BaseInitState(),
        deleteFileEntry: BaseInitState(),
      );

  FileEntryState copyWith({
    BaseState? getLibraryFileEntries,
    BaseState? getFileEntry,
    BaseState? createFileEntry,
    BaseState? updateFileEntry,
    BaseState? deleteFileEntry,
  }) {
    return FileEntryState(
      getLibraryFileEntries:
          getLibraryFileEntries ?? this.getLibraryFileEntries,
      getFileEntry: getFileEntry ?? this.getFileEntry,
      createFileEntry: createFileEntry ?? this.createFileEntry,
      updateFileEntry: updateFileEntry ?? this.updateFileEntry,
      deleteFileEntry: deleteFileEntry ?? this.deleteFileEntry,
    );
  }

  @override
  String toString() {
    return '$FileEntryState('
        'getLibraryFileEntries: $getLibraryFileEntries, '
        'getFileEntry: $getFileEntry'
        'createFileEntry: $createFileEntry'
        'createFileEntry: $createFileEntry'
        'updateFileEntry: $updateFileEntry'
        'deleteFileEntry: $deleteFileEntry'
        ')';
  }
}

class LibraryFileEntriesSuccess extends BaseSuccessState {
  final List<FileEntryEntity> fileEntries;

  const LibraryFileEntriesSuccess({required this.fileEntries});

  @override
  List<Object> get props => [fileEntries];

  @override
  String toString() => '$LibraryFileEntriesSuccess(fileEntries: $fileEntries)';
}

class FileEntrySuccess extends BaseSuccessState {
  final FileEntryEntity khatma;

  const FileEntrySuccess({required this.khatma});

  @override
  List<Object> get props => [khatma];

  @override
  String toString() => '$FileEntrySuccess(khatma: $khatma)';
}
