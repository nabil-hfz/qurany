// Dart imports:
import 'dart:io';

// Project imports:
import 'package:salon_app/core/constants/app_endpoints.dart';

extension UrlBuilder on String {
  String get toUrl {
    return '${AppEndpoints.getFileManager}?name=$this';
    // return Uri(
    //     path: AppEndpoints.getFileManager,
    //     queryParameters: {'name': this}).toString();
  }
}

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
