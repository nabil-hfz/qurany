// import 'dart:developer';
// import 'dart:io';
//
// import 'package:faker/faker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:podlife/di/components/dependency_injection_manager.dart';
// import 'package:podlife/models/upload/upload_model.dart';
//
// class FirebaseUploader {
//   Future<TaskSnapshot> uploadImage({
//     required UploadModel file,
//   }) async {
//     try {
//       var uid = FirebaseAuth.instance.currentUser?.uid ?? '';
//       final pathSec = '${faker.guid.guid()}=${uid}=${file.name}';
//       TaskSnapshot snapshot = await DIManager.findFSC()
//           .ref("images")
//           .child(pathSec)
//           .putFile(file.file!);
//       return snapshot;
//     } catch (e, s) {
//       log(
//         '.........................FIREBASE ERROR 1 ......................\n${e}--stacktrace is $s\n...',
//       );
//       throw e;
//     }
//   }
//
//   Future<TaskSnapshot> uploadAudio({
//     required UploadModel file,
//   }) async {
//     try {
//       var uid = FirebaseAuth.instance.currentUser?.uid ?? '';
//       final pathSec = '${faker.guid.guid()}=${uid}=${file.name}';
//       TaskSnapshot snapshot = await DIManager.findFSC()
//           .ref("audios")
//           .child(pathSec)
//           .putFile(file.file!);
//       return snapshot;
//     } catch (e, s) {
//       log(
//         '.........................FIREBASE ERROR 2......................\n${e.toString()}\n...',
//       );
//
//       /// TODO:
//       /// E/flutter (13687): [ERROR:flutter/lib/ui/ui_dart_state.cc(198)] Unhandled Exception: [firebase_storage/unauthorized] User is not authorized to perform the desired action.
//       // E/flutter (13687): #0      FirebaseUploader.uploadAudio (package:podlife/data/network/firebase/firebase_uploader.dart:38:7)
//       // E/flutter (13687): <asynchronous suspension>
//       // E/flutter (13687): #1      FileApi.uploadFile (package:podlife/data/remote/datasources/file/file_remote_data_source.dart:50:12)
//       // E/flutter (13687): <asynchronous suspension>
//       // E/flutter (13687): #2      ImplFileRepository.uploadFile (package:podlife/data/repositories/file/impl_file_repository.dart:25:21)
//       // E/flutter (13687): <asynchronous suspension>
//       // E/flutter (13687): #3      FileCubit.uploadFile (package:podlife/blocs/file/file_cubit.dart:36:20)
//       // E/flutter (13687): <asynchronous suspension>
//       // E/flutter (13687):
//       // [Nabil] .........................FIREBASE ERROR 2......................
//       throw e;
//     }
//   }
//
//   Future<TaskSnapshot> uploadVideos({
//     required UploadModel file,
//   }) async {
//     try {
//       var uid = FirebaseAuth.instance.currentUser?.uid ?? '';
//       final pathSec = '${faker.guid.guid()}=${uid}=${file.name}';
//       TaskSnapshot snapshot = await DIManager.findFSC()
//           .ref("videos")
//           .child(pathSec)
//           .putFile(file.file!);
//       return snapshot;
//     } catch (e, s) {
//       log(
//         '.........................FIREBASE ERROR 2......................\n${e.toString()}\n...',
//       );
//       throw e;
//     }
//   }
//
//   Future<TaskSnapshot> uploadFile({
//     required File file,
//   }) async {
//     try {
//       var uid = FirebaseAuth.instance.currentUser?.uid ?? '';
//       final pathSec =
//           '${faker.guid.guid()}=${uid}=${file.path.split('/').last}';
//       print('external_files is : $pathSec');
//       print('external_files is : ${file.path}');
//       TaskSnapshot snapshot = await DIManager.findFSC()
//           .ref('external_files')
//           .child(pathSec)
//           .putFile(file);
//       return snapshot;
//     } catch (e, s) {
//       log(
//         '.........................FIREBASE ERROR 2......................\n${e.toString()}\n...',
//       );
//       throw e;
//     }
//   }
// }
