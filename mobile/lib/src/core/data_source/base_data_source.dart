import 'package:kawtharuna/src/core/models/result.dart';

// import 'package:kawtharuna/src/core/models/result.dart';
//
// abstract class BaseDataSource {
//   const BaseDataSource();
//   Future<Result<T>> transform<T>(T Function() data) {
//     return Future.delayed(const Duration(seconds: 1), () {
//       return Future.value(Result(data: data()));
//     });
//   }
// }
Future<Result<T>> transform<T>(T Function() data) {
  return Future.delayed(const Duration(seconds: 2), () {
    return Future.value(Result(data: data()));
  });
}
