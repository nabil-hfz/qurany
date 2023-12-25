import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class LocalModule {
  /// A singleton preference provider.
  ///
  /// Calling it multiple times will return the same instance.
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  /// A singleton Internet Connection Checker provider.
  ///
  /// Calling it multiple times will return the same instance and awaiting
  /// and registering its resolved value at the end.
  @preResolve
  Future<InternetConnectionChecker> get checker =>
      Future.value(InternetConnectionChecker.createInstance());
}
