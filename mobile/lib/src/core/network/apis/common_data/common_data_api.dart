// import 'dart:async';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:podlife/data/network/firebase/firebase_collections.dart';
// import 'package:podlife/data/network/firebase/firestore_service.dart';
// import 'package:podlife/models/name/name_model.dart';
// import 'package:podlife/models/profile/model/badge_model.dart';
// import 'package:podlife/results/result.dart';
//
// class CommonDataApi {
//   CommonDataApi(this.firestore);
//
//   final FirebaseFirestore firestore;
//
//   Future<Result<List<NameIdModel>>> callEducations() async {
//     final collection = [FirebaseCollections.EDUCATIONS].join('/');
//
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) => NameIdModel.fromSnapShot(
//         data!,
//         collection + '/' + documentID,
//       ),
//     );
//   }
//
//   Future<Result<List<NameIdModel>>> callInterests() async {
//     final collection = [FirebaseCollections.INTERESTS].join('/');
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) =>
//           NameIdModel.fromSnapShot(data!, collection + '/' + documentID),
//     );
//   }
//
//   Future<Result<List<NameIdModel>>> callIndustries() async {
//     final collection = [FirebaseCollections.INDUSTRY_TYPE].join('/');
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) =>
//           NameIdModel.fromSnapShot(data!, collection + '/' + documentID),
//     );
//   }
//
//   Future<Result<List<NameIdModel>>> callSpecialities() async {
//     final collection = [FirebaseCollections.SPECIALTY].join('/');
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) =>
//           NameIdModel.fromSnapShot(data!, collection + '/' + documentID),
//     );
//   }
//
//   Future<Result<List<NameIdModel>>> callJoiningObjectives() async {
//     final collection = [FirebaseCollections.OBJECTIVES].join('/');
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) {
//         return NameIdModel.fromSnapShot(
//           data!,
//           collection + '/' + documentID,
//         );
//       },
//     );
//   }
//
//   Future<Result<List<BadgeModel>>> callBadges() async {
//     final collection = FirebaseCollections.BADGES;
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) => BadgeModel.fromSnapShot(data!, documentID),
//     );
//   }
//
//   Future<Result<List<NameIdModel>>> callCategories() async {
//     final collection = [FirebaseCollections.PODCAST_CATEGORIES].join('/');
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) =>
//           NameIdModel.fromSnapShot(data!, collection + '/' + documentID),
//     );
//   }
//
//   Future<Result<List<NameIdModel>>> callSubCategories({
//     required String categoryId,
//   }) async {
//     final collection = [
//       // FirebaseCollections.PODCAST_CATEGORIES,
//       categoryId,
//       FirebaseCollections.PODCAST_SUB_CATEGORY
//     ].join('/');
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) => NameIdModel.fromSnapShot(
//           data!, FirebaseCollections.PODCAST_SUB_CATEGORY + '/' + documentID),
//     );
//   }
//
//   Future<Result<List<NameIdModel>>> callFormat() async {
//     final collection = [FirebaseCollections.PODCAST_FORMATS].join('/');
//     return await FirestoreService.requestDataListObject(
//       collection: collection,
//       builder: (data, documentID) =>
//           NameIdModel.fromSnapShot(data!, collection + '/' + documentID),
//     );
//   }
// }
//
// enum PodcastBadgeEnum {
//   voiceOver,
//   musician,
//   scriptWriter,
//   soundEngineer,
//   director,
//   sponsorShip,
//   producer,
// }
