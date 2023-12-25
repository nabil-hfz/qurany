import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:kawtharuna/src/core/constants/app_strings.dart';
import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/models/empty_result/empty_result_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/core/network/constants/auth_error_const.dart';
import 'package:kawtharuna/src/core/network/exceptions/errors.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:rxdart/rxdart.dart';

class ServerTimestampConverter {
  static DateTime? fromJson(Object? obj) {
    if (obj is Timestamp) {
      return obj.toDate();
    }
    if (obj is DateTime) {
      return obj.toLocal();
    }
    // if (obj is Map) {
    //   return Timestamp(
    //     obj['_seconds'],
    //     obj['_nanoseconds'],
    //   ).toDate().toLocal();
    // }

    return null;
  }

  static Object? toJson(Object? fieldValue) {
    // print('to json nabil dddddd $fieldValue');
    if (fieldValue is DateTime) {
      return Timestamp.fromDate(fieldValue);
    }
    if (fieldValue != null) return fieldValue;
    if (fieldValue == null) return null;
    return FieldValue.serverTimestamp();
  }

  static Object? toJsonDate(Object? fieldValue) {
    return FieldValue.serverTimestamp();
  }
}

class ReferenceIdConverter {
  static String fromJson(Object? obj) {
    // print('ReferenceIdConverter obj $obj');
    if (obj is DocumentReference) {
      return obj.path;
    }
    // if (obj is Map) {
    //   if (obj.containsKey('_path')) {
    //     if (obj['_path'].containsKey('segments')) {
    //       final res = (obj['_path']['segments'] as List).join('/').toString();
    //       return res;
    //     }
    //   }
    // }

    if (obj is String) return obj;
    return '$obj';
  }

  static Object? toJson(Object? obj) {
    // print('obj is sdkjflajfsajkflf ($obj)');
    if (obj == null ||
        (obj is String && (obj.contains('null') || obj.isEmpty))) {
      return null;
    }
    if (obj is String) {
      if (obj.startsWith('https')) return obj;
      final paths = obj.split('/');
      String collection = paths.first;
      if (paths.isEmpty) return null;
      if (paths.first == '' || paths.first == '/') collection = '/${paths[1]}';
      return FirebaseFirestore.instance
          .collection((collection.startsWith('/') ? '' : '/') + collection)
          .doc(obj.substring(collection.length));
    }
    return obj.toString();
  }
}

abstract class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final _log = Logger('FirestoreService');

  /// //////////////////////
  static Future<Result<T>> requestDataObject<T>({
    bool isFileApi = false,
    required String collection,
    required String docId,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) async {
    try {
      if (docId.isEmpty) return Result(error: NotFoundError());
      var query = _firestore.collection(collection).doc(docId);
      //  query.
      // if (queryBuilder != null) query = queryBuilder(query)!;

      final DocumentSnapshot<Map<String, dynamic>> snapshots =
          await query.get();

      final result = builder(snapshots.data(), snapshots.id);

      return Result(
        data: result,
      );
    } catch (error, stack) {
      if (!isFileApi) {
        _log.severe(
          '${AppStrings.firebaseErrorLevel} requestDataObject: ',
          error,
          stack,
        );
      }

      AppUtils.debugPrint(
          "requestDataObject complete path is ($collection/$docId)");
      log('_______________________ '
          'requestDataObject EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      log('requestDataObject error is $error');
      log('requestDataObject stack is $stack');
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    }
  }

  /// //////////////////////
  static Future<Result<List<T>>> requestDataListObject<T>({
    bool isFileApi = false,
    required String collection,
    required T Function(
      Map<String, dynamic>? data,
      String documentID,
    ) builder,
    Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
    void Function(DocumentSnapshot documentSnapshot)? passingLastDocument,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection(collection);
      if (queryBuilder != null) query = queryBuilder(query)!;

      final QuerySnapshot<Map<String, dynamic>> snapshots = await query.get();
      AppUtils.debugPrint(
          "snapshots.docs length is ${snapshots.docs.length}  | collection is $collection");

      final result = snapshots.docs
          .map((e) => builder(e.data(), e.id))
          // .where((element) => element != null)
          .toList();
      if (sort != null) result.sort(sort);
      if (passingLastDocument != null && snapshots.docs.isNotEmpty) {
        passingLastDocument(snapshots.docs.last);
      }

      return Result(
        data: result,
      );
    } catch (error, stack) {
      log('_______________________ '
          'requestDataListObject EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint(
          "requestDataListObject complete path is ($collection)");
      log('requestDataListObject error is $error');
      log('requestDataListObject stack is $stack');
      if (!isFileApi) {
        _log.severe(
          '${AppStrings.firebaseErrorLevel} requestDataListObject: ',
          error,
          stack,
        );
      }
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    }
  }

  // static Future<Result<T>> callFunction<T>({
  //   required String path,
  //   Map<String, dynamic>? params,
  //   required T Function(
  //     Map<String, dynamic>? data,
  //     String? documentID,
  //   )
  //       builder,
  //   Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
  //       queryBuilder,
  //   int Function(T lhs, T rhs)? sort,
  //   void Function(DocumentSnapshot documentSnapshot)? passingLastDocument,
  // }) async {
  //   try {
  //     log('cluod function is path ${path} || ${params}');
  //     final response = await DIManager.findFFsC()
  //         .httpsCallable(
  //           path,
  //           options: HttpsCallableOptions(
  //             timeout: Duration(
  //               seconds: Endpoints.connectionTimeout,
  //             ),
  //           ),
  //         )
  //         .call(params);
  //     log('cluod function is result ${response.data}');
  //     final result = builder(
  //       response.data,
  //       response.data.toString(),
  //     );
  //
  //     return Result(
  //       data: result,
  //     );
  //   } catch (error, stack) {
  //     _log.severe(
  //       '${AppStrings.firebaseErrorLevel} callFunction: ',
  //       error,
  //       stack,
  //     );
  //     log('_______________________ '
  //         'callFunction EXCEPTION ON FirestoreService LEVEL '
  //         '______________________');
  //     AppUtils.debugPrint("callFunction complete path is ($path)");
  //     log('callFunction error is $error');
  //     log('callFunction stack is $stack');
  //     log('handleFirebaseError(error.toString(), error) is ${handleFirebaseError(error.toString(), error)}');
  //     return Result(
  //       error: handleFirebaseError(error.toString(), error),
  //     );
  //   }
  // }

  static Future<Result<MODEL>> request<@required MODEL>({
    required Future<MODEL> Function() callback,
  }) async {
    try {
      final res = await callback();
      if (res == null && MODEL is EmptyResultModel) {
        return Result(data: EmptyResultModel() as MODEL);
      }

      return Result(data: res);
    } catch (error, stack) {
      _log.severe(
        '${AppStrings.firebaseErrorLevel} request: ',
        error,
        stack,
      );
      log('_______________________ '
          'request EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      log('request error is $error');
      log('request stack is $stack');
      return Result(error: handleFirebaseError(error.toString(), error));
    }
  }

  /// POST HTTPS REQUEST
  static Future<Result<EmptyResultModel>> setData({
    required String collection,
    required String? path,
    required Map<String, dynamic> Function() data,
    bool merge = false,
  }) async {
    try {
      AppUtils.debugPrint('{collection}/{path} : $collection/$path');
      final reference = _firestore.collection(collection).doc(
            path,
          );
      AppUtils.debugPrint('setData reference path is : ${reference.path}');

      await reference.set(data(), SetOptions(merge: merge));
      return Result(data: EmptyResultModel());
    } catch (error, stack) {
      _log.severe(
        '${AppStrings.firebaseErrorLevel} setData: ',
        error,
        stack,
      );
      log('_______________________ '
          'setData EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint("setData complete path is ($collection/$path)");
      log('setData error is $error');
      log('setData stack is $stack');
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    }
  }

  /// POST HTTPS REQUEST
  static Future<Result<T>> setDataWithReturn<T>({
    required String collection,
    required String path,
    required T Function() returnData,
    required Map<String, dynamic> Function() data,
    bool merge = false,
  }) async {
    try {
      AppUtils.debugPrint('{collection}/{path} : $collection/$path');
      final reference = _firestore.collection(collection).doc(
            path,
          );
      AppUtils.debugPrint('setData reference path is : ${reference.path}');

      await reference.set(data(), SetOptions(merge: merge));
      return Result(data: returnData());
    } catch (error, stack) {
      _log.severe(
        '${AppStrings.firebaseErrorLevel} setDataWithReturn: ',
        error,
        stack,
      );
      log('_______________________ '
          'setDataWithReturn EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint(
          "setDataWithReturn complete path is ($collection/$path)");
      log('setDataWithReturn error is $error');
      log('setDataWithReturn stack is $stack');
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    }
  }

  static DocumentReference? getFirebaseReferenced({
    required String collection,
    String? id,
    bool isFileApi = false,
  }) {
    try {
      return _firestore.collection(collection).doc(id);
    } catch (error, stack) {
      log('_______________________ '
          'getFirebaseDocumentId EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint(
          "setDataWithReturn complete path is ($collection/$id)");
      log('getFirebaseDocumentId error is $error');
      log('getFirebaseDocumentId stack is $stack');
      if (!isFileApi) {
        _log.severe(
          '${AppStrings.firebaseErrorLevel} getFirebaseDocumentId: ',
          error,
          stack,
        );
      }
      return null;
    }
  }

  static String getFirebaseDocumentId({
    required String path,
    bool isFileApi = false,
  }) {
    try {
      return _firestore.collection(path).doc().id;
    } catch (error, stack) {
      log('_______________________ '
          'getFirebaseDocumentId EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint("setDataWithReturn complete path is ($path)");
      log('getFirebaseDocumentId error is $error');
      log('getFirebaseDocumentId stack is $stack');
      if (!isFileApi) {
        _log.severe(
          '${AppStrings.firebaseErrorLevel} getFirebaseDocumentId: ',
          error,
          stack,
        );
      }
      return '';
    }
  }

  static Future<Result<EmptyResultModel>> updateData({
    required String collection,
    required String path,
    required Map<String, dynamic> Function() data,
  }) async {
    try {
      AppUtils.debugPrint('update {collection}/$path : $collection/$path');
      final reference = _firestore.collection(collection).doc(
            path,
          );

      await reference.update(
        data(),
      );
      return Result(data: EmptyResultModel());
    } catch (error, stack) {
      _log.severe(
        '${AppStrings.firebaseErrorLevel} updateData: ',
        error,
        stack,
      );
      log('_______________________ '
          'updateData EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint("updateData complete path is ($collection/$path)");
      log('updateData error is $error');
      log('updateData stack is $stack');
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    }
  }

  static Future<Result<EmptyResultModel>> delete({
    required String collection,
    required String path,
  }) async {
    try {
      AppUtils.debugPrint('{collection}/$path : $collection/$path');
      final reference = _firestore.collection(collection).doc(path);
      AppUtils.debugPrint('setData reference path is : ${reference.path}');
      await reference.delete();

      return Result(data: EmptyResultModel());
    } catch (error, stack) {
      _log.severe(
        '${AppStrings.firebaseErrorLevel} delete: ',
        error,
        stack,
      );
      log('_______________________ '
          'delete EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint("delete complete path is ($collection/$path)");
      log('delete error is $error');
      log('delete stack is $stack');
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    }
  }

  static Future<Result<EmptyResultModel>> deleteOnId({
    required String collection,
    Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
  }) async {
    try {
      AppUtils.debugPrint('{collection} : $collection');
      Query<Map<String, dynamic>> query = _firestore.collection(collection);
      if (queryBuilder != null) query = queryBuilder(query)!;
      final foo = await query.get();

      // AppUtils.debugPrint(
      //     'foo.docs.first.reference reference path is : ${foo.docs.first.reference}');
      await _firestore.collection(collection).doc(foo.docs.first.id).delete();

      return Result(data: EmptyResultModel());
    } catch (error, stack) {
      _log.severe(
        '${AppStrings.firebaseErrorLevel} deleteOnId: ',
        error,
        stack,
      );
      log('_______________________ '
          'deleteOnId EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint("deleteOnId complete path is ($collection)");
      log('deleteOnId error is $error');
      log('deleteOnId stack is $stack');
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    }
  }

  static Stream<Result<List<T>>> collectionStream<T>({
    required String collection,
    required T Function(
      Map<String, dynamic>? data,
      String documentID,
    ) builder,
    Query<Map<String, dynamic>>? Function(Query<Map<String, dynamic>> query)?
        queryBuilder,
    int Function(T lhs, T rhs)? sort,
    List<T> Function(List<T>)? filterMethod,
    void Function(DocumentSnapshot documentSnapshot)? passingLastDocument,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(collection);
    if (queryBuilder != null) query = queryBuilder(query)!;

    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
        query.snapshots(includeMetadataChanges: true);
    return snapshots.map((snapshot) {
      var result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (filterMethod != null) result = filterMethod(result);
      if (sort != null) result.sort(sort);
      if (passingLastDocument != null && snapshot.docs.isNotEmpty) {
        passingLastDocument(snapshot.docs.last);
      }

      return Result(
        data: result,
      );
    }).onErrorReturnWith((error, stack) {
      log('_______________________ '
          'collectionStream EXCEPTION ON FirestoreService LEVEL 1'
          '______________________');
      AppUtils.debugPrint("collectionStream complete path is ($collection)");
      log('collectionStream error is $error');
      log('collectionStream stack is $stack');
      _log.severe(
        '${AppStrings.firebaseErrorLevel} collectionStream: ',
        error,
        stack,
      );
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    });
  }

  static Stream<Result<T>> documentStream<T>({
    required String collection,
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final DocumentReference<Map<String, dynamic>> reference =
        _firestore.collection(collection).doc(path);
    final Stream<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        reference.snapshots();
    return snapshots.map(
      (snapshot) {
        return Result(
          data: builder(snapshot.data(), snapshot.id),
        );
      },
    ).onErrorReturnWith((error, stack) {
      AppUtils.debugPrint('{collection/path} : $collection/$path');
      // _log.severe(
      //   '${AppStrings.firebaseErrorLevel} documentStream: ',
      //   error,
      //   stack,
      // );
      log('_______________________ '
          'documentStream EXCEPTION ON FirestoreService LEVEL '
          '______________________');
      AppUtils.debugPrint(
          "documentStream complete path is ($collection/$path)");
      log('documentStream error is $error');
      log('documentStream stack is $stack');
      return Result(
        error: handleFirebaseError(error.toString(), error),
      );
    });
  }

  static BaseError handleFirebaseError(String errorAsString, dynamic error) {
    if (errorAsString.contains(ERROR_INVALID_EMAIL)) {
      return NotValidEmailError();
    } else if (errorAsString.contains(ERROR_EMAIL_ALREADY_IN_USE)) {
      return EmailAlreadyInUseError();
    } else if (errorAsString.contains(ERROR_TOO_MANY_REQUESTS)) {
      return TooManyRequestError();
    } else if (errorAsString.contains(ERROR_OPERATION_NOT_ALLOWED)) {
      return OperationNotAllowedError();
    } else if (errorAsString.contains(ERROR_USER_DISABLED)) {
      return UserDisabledError();
    } else if (errorAsString.contains(ERROR_USER_NOT_FOUND)) {
      return UserNotFoundError();
    } else if (errorAsString.contains(ERROR_WRONG_PASSWORD)) {
      return WrongPasswordError();
    } else if (errorAsString.contains(ERROR_INVALID_CREDENTIAL)) {
      return CustomError(message: translate.err_invalid_credential);
    } else if (errorAsString
        .contains('user_auth/account-exists-with-different-credential')) {
      return DuplicatedCredentialError();
    } else if (error is NoSuchMethodError) {
      return NotFoundError();
    } else {
      return UnExpectedError();
    }
  }
}
