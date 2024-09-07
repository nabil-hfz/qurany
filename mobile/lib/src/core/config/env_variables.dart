abstract class EnvVariables {
  static late String apiURL;

  static late String appName;
  static late bool isProduction;

  static void initiateVariables() {
    apiURL = const String.fromEnvironment('APP_BASE_URL');
    appName = const String.fromEnvironment('APP_NAME');
    const env = String.fromEnvironment('ENV');
    if (env == "prod") {
      isProduction = true;
    } else {
      isProduction = false;
    }
  }
}
