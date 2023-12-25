// import 'dart:developer';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:podlife/data/network/exceptions/firebase_error/unexpected_error.dart';
// import 'package:podlife/di/components/dependency_injection_manager.dart';
// import 'package:podlife/models/base/empty_response_model.dart';
// import 'package:podlife/models/podcast_comment/comment_model.dart';
// import 'package:podlife/models/task/task_model.dart';
// import 'package:podlife/results/result.dart';
// import 'package:podlife/utils/locals/translation/translate.dart';
//
// import '../../../../models/upload/upload_model.dart';
// import '../../../network/firebase/firebase_collections.dart';
// import '../../../network/firebase/firestore_service.dart';
//
// class FileApi {
//   const FileApi();
//
//   Future<Result<StringResultModel>> uploadFile({
//     required UploadModel upload,
//   }) async {
//     try {
//       return await DIManager.findFPC()
//           .uploadFile(file: upload.file!)
//           .then((value) async {
//         if (value.state == TaskState.success) {
//           final result = await value.ref.getDownloadURL();
//           final fileId = FirestoreService.getFirebaseDocumentId(
//             path: FirebaseCollections.UPLOADS,
//             isFileApi: true,
//           );
//
//           ///
//           /// Upload the podcast
//           return FirestoreService.setDataWithReturn(
//             collection: FirebaseCollections.UPLOADS,
//             path: fileId,
//             merge: true,
//             returnData: () {
//               return StringResultModel(FirebaseCollections.UPLOADS + fileId);
//             },
//             data: () {
//               return upload
//                   .copyWith(
//                     url: result,
//                     id: fileId,
//                   )
//                   .toJson();
//             },
//           );
//         }
//         return Result(
//           error: UnExpectedError(
//               message: translate.error_could_not_upload_the_file),
//         );
//       });
//     } catch (error, stack) {
//       log('_______________________ '
//           'uploadFile EXCEPTION ON FileApi LEVEL '
//           '______________________');
//       log('error is $error');
//       log('stack is $stack');
//       return Result(
//         error: FirestoreService.handleFirebaseError(error.toString(), error),
//       );
//     }
//   }
//
//   Future<Result<StringResultModel>> uploadImage(
//     UploadModel upload, {
//     bool fileIsLinkAlready = false,
//   }) async {
//     try {
//       final fileId = FirestoreService.getFirebaseDocumentId(
//         path: FirebaseCollections.UPLOADS,
//         isFileApi: true,
//       );
//
//       if (!fileIsLinkAlready)
//         return await DIManager.findFPC().uploadImage(file: upload).then(
//           (value) async {
//             if (value.state == TaskState.success) {
//               final result = await value.ref.getDownloadURL();
//
//               ///
//               /// Upload the image
//               return FirestoreService.setDataWithReturn(
//                 collection: FirebaseCollections.UPLOADS,
//                 path: fileId,
//                 merge: true,
//                 data: () {
//                   return upload
//                       .copyWith(
//                         url: result,
//                         id: fileId,
//                       )
//                       .toJson();
//                 },
//                 returnData: () {
//                   return StringResultModel(
//                       FirebaseCollections.UPLOADS + fileId);
//                 },
//               );
//             }
//             return Result(
//               error: UnExpectedError(
//                 message: translate.error_could_not_upload_the_image,
//               ),
//             );
//           },
//         );
//       else
//
//         ///
//         /// Upload the image link directly
//         return FirestoreService.setDataWithReturn(
//           collection: FirebaseCollections.UPLOADS,
//           path: fileId,
//           merge: true,
//           returnData: () {
//             return StringResultModel(FirebaseCollections.UPLOADS + fileId);
//           },
//           data: () {
//             return upload
//                 .copyWith(
//                   url: upload.url,
//                   id: fileId,
//                 )
//                 .toJson();
//           },
//         );
//     } catch (error, stack) {
//       log('_______________________ '
//           'uploadImage EXCEPTION ON FileApi LEVEL '
//           '______________________');
//       log('error is $error');
//       log('stack is $stack');
//       return Result(
//         error: FirestoreService.handleFirebaseError(error.toString(), error),
//       );
//     }
//   }
//
//   Future<Result<StringResultModel>> uploadAudio(
//     UploadModel upload, {
//     bool fileIsLinkAlready = false,
//   }) async {
//     try {
//       final fileId = FirestoreService.getFirebaseDocumentId(
//         path: FirebaseCollections.UPLOADS,
//         isFileApi: true,
//       );
//       log('FileApi uploadAudio upload: ${upload.toEntity().toString()}, fileIsLinkAlready: $fileIsLinkAlready');
//       if (!fileIsLinkAlready)
//         return await DIManager.findFPC()
//             .uploadAudio(file: upload)
//             .then((value) async {
//           if (value.state == TaskState.success) {
//             final result = await value.ref.getDownloadURL();
//
//             ///
//             /// Upload the podcast
//             return FirestoreService.setDataWithReturn(
//               collection: FirebaseCollections.UPLOADS,
//               path: fileId,
//               merge: true,
//               returnData: () {
//                 return StringResultModel(FirebaseCollections.UPLOADS + fileId);
//               },
//               data: () {
//                 return upload
//                     .copyWith(
//                       url: result,
//                       id: fileId,
//                     )
//                     .toJson();
//               },
//             );
//           }
//           return Result(
//             error: UnExpectedError(
//                 message: translate.error_could_not_upload_the_audio),
//           );
//         });
//
//       ///
//       /// Upload the audio link directly
//       return FirestoreService.setDataWithReturn(
//         collection: FirebaseCollections.UPLOADS,
//         path: fileId,
//         merge: true,
//         returnData: () {
//           return StringResultModel(FirebaseCollections.UPLOADS + fileId);
//         },
//         data: () {
//           return upload
//               .copyWith(
//                 url: upload.url,
//                 id: fileId,
//               )
//               .toJson();
//         },
//       );
//     } catch (error, stack) {
//       log('_______________________ '
//           'uploadAudio EXCEPTION ON FileApi LEVEL '
//           '______________________');
//       log('error is $error');
//       log('stack is $stack');
//       return Result(
//         error: FirestoreService.handleFirebaseError(error.toString(), error),
//       );
//     }
//   }
//
//   Future<Result<StringResultModel>> uploadVideo({
//     required UploadModel upload,
//   }) async {
//     try {
//       return await DIManager.findFPC()
//           .uploadVideos(file: upload)
//           .then((value) async {
//         if (value.state == TaskState.success) {
//           final result = await value.ref.getDownloadURL();
//           final fileId = FirestoreService.getFirebaseDocumentId(
//             path: FirebaseCollections.UPLOADS,
//             isFileApi: true,
//           );
//
//           ///
//           /// Upload the podcast
//           return FirestoreService.setDataWithReturn(
//             collection: FirebaseCollections.UPLOADS,
//             path: fileId,
//             merge: true,
//             returnData: () {
//               return StringResultModel(FirebaseCollections.UPLOADS + fileId);
//             },
//             data: () {
//               return upload
//                   .copyWith(
//                     url: result,
//                     id: fileId,
//                   )
//                   .toJson();
//             },
//           );
//         }
//         return Result(
//           error: UnExpectedError(
//               message: translate.error_could_not_upload_the_video),
//         );
//       });
//     } catch (error, stack) {
//       log('_______________________ '
//           'uploadVideo EXCEPTION ON FileApi LEVEL '
//           '______________________');
//       log('error is $error');
//       log('stack is $stack');
//       return Result(
//         error: FirestoreService.handleFirebaseError(error.toString(), error),
//       );
//     }
//   }
//
//   Future<Result<UploadModel>> getFileData(
//     String reference,
//   ) async {
//     try {
//       final refs = reference.split('/');
//       final collection = refs.first;
//       final id = refs.last;
//       // log('getFileData -1 reference is type is __s__$collection)__0__($id __e__');
//       // log('getFileData 0 reference is type is ${reference.runtimeType} - ($reference)');
//
//       return await FirestoreService.requestDataObject<UploadModel>(
//         isFileApi: true,
//         collection: collection,
//         docId: id,
//         builder: (data, documentID) {
//           // log('getFileData 1 data is $data');
//           // log('getFileData 2 documentID is ${documentID.toString()}');
//           return UploadModel.fromSnapShot(data, reference);
//         },
//       );
//     } catch (error, stack) {
//       log('_______________________ '
//           'getFileData EXCEPTION ON FileApi LEVEL '
//           '______________________');
//       log('getFileData reference is $reference');
//       log('getFileData error is $error');
//       log('getFileData stack is $stack');
//       return Result(
//         error: FirestoreService.handleFirebaseError(error.toString(), error),
//       );
//     }
//   }
//
//   Future<Result<List<UploadModel>>> getFilesData(
//     List<String> references,
//   ) async {
//     try {
//       var result = <UploadModel>[];
//       for (var reference in references) {
//         final refs = reference.split('/');
//         final collection = refs.first;
//         final id = refs.last;
//         var res = await FirestoreService.requestDataObject<UploadModel>(
//           isFileApi: true,
//           collection: collection,
//           docId: id,
//           builder: (data, documentID) {
//             // log('getFilesData 1 data is $data');
//             // log('getFilesData 2 documentID is $documentID');
//             return UploadModel.fromSnapShot(data, reference);
//           },
//         );
//         if (res.hasDataOnly && res.data != null) result.add(res.data!);
//       }
//
//       return Result(data: result);
//     } catch (error, stack) {
//       log('_______________________ '
//           'getFilesData EXCEPTION ON FileApi LEVEL '
//           '______________________');
//       log('getFilesData reference is $references');
//       log('getFilesData error is $error');
//       log('getFilesData stack is $stack');
//       return Result(
//         error: FirestoreService.handleFirebaseError(error.toString(), error),
//       );
//     }
//   }
//
//   Future<Result<List<UploadModel>>> getFiles({
//     required String taskId,
//     required String userId,
//     required int page,
//   }) async {
//     try {
//       final references =
//           await FirestoreService.requestDataListObject<UserTaskHistoryModel>(
//         isFileApi: true,
//         collection: FirebaseCollections.USER_TASKS_HISTORIES,
//         queryBuilder: (querySnapshot) {
//           querySnapshot = querySnapshot.where(
//             'userId',
//             isEqualTo: ReferenceIdConverter.toJson(userId),
//           );
//           querySnapshot = querySnapshot.where(
//             'taskId',
//             whereIn: [ReferenceIdConverter.toJson(taskId)],
//           );
//
//           querySnapshot = querySnapshot.orderBy(
//             "actionDate",
//             descending: true,
//           );
//
//           return querySnapshot;
//         },
//         builder: (data, documentId) {
//           return UserTaskHistoryModel.fromJson(data ?? {});
//         },
//       );
//
//       var result =
//           await Future.wait<UploadModel>(references.data?.map((e) async {
//                 final collection = e.actionDestRef!.split('/')[0];
//                 final path = e.actionDestRef!.split('/')[1];
//
//                 return (await FirestoreService.requestDataObject<UploadModel>(
//                   isFileApi: true,
//                   collection: collection,
//                   docId: path,
//                   builder: (data, documentID) {
//                     log('getFiles 1 data is $data');
//                     log('getFiles 2 documentID is $documentID');
//                     return UploadModel.fromSnapShot(data!, e.actionDestRef!);
//                   },
//                 ))
//                     .data!;
//               }).toList() ??
//               []);
//       return Result(data: result);
//     } catch (error, stack) {
//       log('_______________________ '
//           'getFiles for task case EXCEPTION ON FileApi LEVEL '
//           '______________________');
//       log('getFiles for task case taskId: $taskId, userId: $userId');
//       log('getFiles error is $error');
//       log('getFiles stack is $stack');
//       return Result(
//         error: FirestoreService.handleFirebaseError(error.toString(), error),
//       );
//     }
//   }
// }
