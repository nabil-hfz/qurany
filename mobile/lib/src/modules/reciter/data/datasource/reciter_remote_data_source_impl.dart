import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/managers/network/dio_client.dart';
import 'package:kawtharuna/src/core/models/empty_result/empty_result_model.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/core/network/firebase/firebase_collections.dart';
import 'package:kawtharuna/src/core/network/firebase/firestore_service.dart';
import 'package:kawtharuna/src/modules/reciter/data/models/reciter_model.dart';

import 'reciter_data_source_i.dart';

@Singleton()
class ReciterRemoteDataSource implements IReciterDataSource {
  // dio instance
  final DioClient _dioClient;
  DocumentSnapshot? reciters;

  // injecting dio instance
  ReciterRemoteDataSource(this._dioClient) {
    _dioClient.toString();
  }

  @override
  Future<Result<ReciterModel>> createReciter({
    required ReciterModel reciter,
    CancelToken? cancelToken,
  }) async {
    final id = FirestoreService.getFirebaseDocumentId(
      path: FirebaseCollections.reciters,
    );
    await FirestoreService.setData(
      collection: FirebaseCollections.reciters,
      path: id,
      data: () {
        final data = reciter.toJson();
        data['id'] = FirestoreService.getFirebaseReferenced(
          collection: FirebaseCollections.reciters,
          id: id,
        );
        data['createdDate'] = FieldValue.serverTimestamp();
        return data;
      },
    );
    return await FirestoreService.requestDataObject(
      collection: FirebaseCollections.reciters,
      docId: id,
      builder: (json, id) {
        return ReciterModel.fromSnapShot(json, id);
      },
    );
  }

  @override
  Future<Result<EmptyResultModel>> deleteReciter({
    required String id,
    CancelToken? cancelToken,
  }) async {
    return await FirestoreService.delete(
      collection: FirebaseCollections.reciters,
      path: id,
    );
  }

  @override
  Future<Result<ReciterModel>> getReciter({
    required String id,
    CancelToken? cancelToken,
  }) async {
    return await FirestoreService.requestDataObject(
      collection: FirebaseCollections.reciters,
      docId: id,
      builder: (json, id) {
        return ReciterModel.fromSnapShot(json, id);
      },
    );
  }

  @override
  Future<Result<List<ReciterModel>>> getReciters({
    CancelToken? cancelToken,
  }) async {
    return await FirestoreService.requestDataListObject(
      collection: FirebaseCollections.reciters,
      passingLastDocument: (lastDoc) => reciters = lastDoc,
      builder: (json, id) {
        return ReciterModel.fromSnapShot(json, id);
      },
    );
  }

  @override
  Future<Result<ReciterModel>> updateReciter({
    required ReciterModel reciter,
    CancelToken? cancelToken,
  }) async {
    await FirestoreService.updateData(
      collection: FirebaseCollections.reciters,
      path: reciter.id!,
      data: () {
        final data = reciter.toJson();
        data['id'] = FirestoreService.getFirebaseReferenced(
          collection: FirebaseCollections.reciters,
          id: reciter.id!,
        );
        data['updatedAt'] = FieldValue.serverTimestamp();
        return data;
      },
    );
    return await FirestoreService.requestDataObject(
      collection: FirebaseCollections.reciters,
      docId: reciter.id!,
      builder: (json, id) {
        return ReciterModel.fromSnapShot(json, id);
      },
    );
  }
}
