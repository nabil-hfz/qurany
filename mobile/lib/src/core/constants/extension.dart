// Dart imports:
import 'dart:io';

extension StringExtension on String {
  String get getExtension {
    return ".${split('.').last}";
  }

  String get getName {
    return split('/').last;
  }
}

extension FileExtension on File {
  String get getFileExtension => path.getExtension;

  String get getFileName => path.getName;
}
