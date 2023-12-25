import 'package:kawtharuna/main.dart';

class Endpoints {
  Endpoints._();

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;

  // booking endpoints
  static String getPosts = "${envVariables.baseLink}/podcast";
  static const String registerUser = "/users/registration";
  static const String verifyUser = "/users/verificationStatus";
  static const String deleteUser = "/users/";
  static const String userInvitation = "/userInvitation/";
  static const String currentTime = "/current-time";

  static const addNewPodcastMethod = 'addPodcast';
  static const getVersionMethod = 'getVersion';
  static const updatePodcastMethod = 'updatePodcast';
  static const deletePodcastMethod = 'deletePodcast';
  static const clubAskToJoin = '/clubs/request-join';
//
// /// EXTERNAL LINKS
// static const String PRIVACY_POLICY =
//     'https://www.podlines.net/en/privacy-policy-2/';
// static const String TERMS_OF_SERVICES =
//     'https://www.podlines.net/en/terms-of-service/';
}
