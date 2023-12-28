import 'package:kawtharuna/main.dart';

class AppEndpoints {
  AppEndpoints._();

  static const String mockImageUrl =
      "https://images.pexels.com/photos/4148020/pexels-photo-4148020.jpeg";

  static const List<String> mockGalleryImages = [
    "https://picsum.photos/id/13/367/267",
    "https://picsum.photos/id/12/367/267",
    "https://picsum.photos/id/14/367/267",
    "https://picsum.photos/id/15/367/267",
    "https://picsum.photos/id/16/367/267",
    "https://picsum.photos/id/17/367/267",
    "https://picsum.photos/id/18/367/267",
    "https://picsum.photos/id/19/367/267",
    "https://picsum.photos/id/20/367/267",
    "https://picsum.photos/id/22/367/267",
    "https://picsum.photos/id/23/367/267",
    "https://picsum.photos/id/24/367/267",
    "https://picsum.photos/id/25/367/267",
    "https://picsum.photos/id/29/367/267",
    "https://picsum.photos/id/30/367/267",
    "https://picsum.photos/id/32/367/267",
  ];

  // base url
  static String baseUrl = envVariables.baseUrl;

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  static const String posts = "/posts";

  // Staff
  static const String _reciter = "reciter";
  static const String createReciter = _reciter;
  static const String updateReciter = '$_reciter/';
  static const String getReciters = '$_reciter/';
  static const String getReciterDetails = '$_reciter/';
  static const String deleteReciter = '$_reciter/';

  // Khatma
  static const String _khatma = "khatma";
  static const String getKhatmat = '$_khatma/';

  static String getKhatmaDetails(String id) => '$_khatma/$id';
}

abstract class AppQueryParameters {
  AppQueryParameters._();

  static const String id = "id";
  static const String serviceId = "serviceId";
  static const String fileName = "fileName";
  static const String file = "file";
  static const String name = "name";
}
