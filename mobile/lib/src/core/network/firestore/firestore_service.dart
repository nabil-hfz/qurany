// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

/// Initializes [Firebase] and [FirebaseCrashlytics].
///
/// If a non-null [FirebaseCrashlytics] instance is provided through
/// [crashlytics], then all errors will be reported through it.
///
/// These errors will also include latest logs from anywhere in the app
/// that use `package:logging`.
Future<FirebaseCrashlytics?> initFirebaseService() async {
  FirebaseCrashlytics? crashlytics;
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    try {
      await Firebase.initializeApp(
          // options: DefaultFirebaseOptions.currentPlatform,
          );
      crashlytics = FirebaseCrashlytics.instance;
    } catch (e) {
      debugPrint("Firebase couldn't be initialized: $e");
    }
  }
  return crashlytics;
}

/// Takes a [stackTrace] and creates a new one, but without the lines that
/// have to do with this file and logging. This way, Crashlytics won't group
/// all messages that come from this file into one big heap just because
/// the head of the StackTrace is identical.
///
/// See this:
/// https://stackoverflow.com/questions/47654410/how-to-effectively-group-non-fatal-exceptions-in-crashlytics-fabrics.
@visibleForTesting
StackTrace filterStackTrace(StackTrace stackTrace) {
  try {
    final lines = stackTrace.toString().split('\n');
    final buf = StringBuffer();
    for (final line in lines) {
      if (line.contains('crashlytics.dart') ||
          line.contains('_BroadcastStreamController.java') ||
          line.contains('logger.dart')) {
        continue;
      }
      buf.writeln(line);
    }
    return StackTrace.fromString(buf.toString());
  } catch (e) {
    debugPrint('Problem while filtering stack trace: $e');
  }

  // If there was an error while filtering,
  // return the original, unfiltered stack track.
  return stackTrace;
}
