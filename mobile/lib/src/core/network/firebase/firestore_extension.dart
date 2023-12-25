import 'package:kawtharuna/src/core/network/firebase/firebase_collections.dart';

extension FirebaseExtension on String {
  String get buildCommentsPath {
    String temp = this;
    temp = temp.replaceAll(RegExp(r'//'), '/');
    temp = '$temp${temp.endsWith('/') ? '' : '/'}comments';
    temp = temp.replaceAll(RegExp(r'//'), '/');
    return temp;
  }

  String get buildPostPath => this;

  String get buildEvaluationsPath {
    String temp = this;
    temp = temp.replaceAll(RegExp(r'//'), '/');
    temp = '$temp${temp.endsWith('/') ? '' : '/'}usersEvaluations';
    temp = temp.replaceAll(RegExp(r'//'), '/');
    return temp;
  }

  String get buildClapPath {
    String temp = this;
    temp = temp.replaceAll(RegExp(r'//'), '/');
    temp = '$temp${temp.endsWith('/') ? '' : '/'}clap';
    temp = temp.replaceAll(RegExp(r'//'), '/');
    return temp;
  }

  String get buildUserReference {
    String temp = this;
    temp.replaceAll(RegExp(r'//'), '/');
    temp = temp.startsWith('users') ? temp : 'users/$temp';
    temp.replaceAll(RegExp(r'//'), '/');
    return temp;
  }

  String get buildCLubPodcastPath =>
      '${FirebaseCollections.reciters}/$this/${FirebaseCollections.reciters}';

  String get buildFeaturedPodcast =>
      startsWith('featured_podcast') ? this : '/featured_podcast/$this';

  String get buildLatestNews => startsWith('/latest_news') ||
          contains('latest_news') ||
          startsWith('latest_news')
      ? this
      : '/latest_news/$this';
}

extension FirebaseComparasionEx on String {
  bool isCurrentUser(String? id) {
    String currentValue = this;
    if (!(id?.startsWith(FirebaseCollections.reciters) ?? true)) {
      id = id!.buildUserReference;
    }
    if (!currentValue.startsWith(FirebaseCollections.reciters)) {
      currentValue = currentValue.buildUserReference;
    }
    return id == currentValue;
  }
}
