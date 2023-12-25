import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class ConnectionChecker {
  Future<bool> checkConnection();
}

class ConnectionCheckerImpl extends ConnectionChecker {
  final InternetConnectionChecker checker;

  ConnectionCheckerImpl(this.checker);

  @override
  Future<bool> checkConnection() async {
    return await checker.hasConnection;
  }
}
