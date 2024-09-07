import 'package:kawtharuna/src/core/constants/app_strings.dart';
import 'package:kawtharuna/src/core/utils/utl_app.dart';

/// This class will contain env specific vars like BASE_URL ...
///
/// In this class the prefix "APP_" will be used before any env var
/// to avoid conflict with flutter env vars
///
/// (FOR DEVELOPERS) Please make sure to return this class values
/// to the origin before push to repo if you edited it while development.
///
/// Here are the args that must  be added to "flutter run" command
/// --dart-define=APP_BASE_URL="some.url.com"
/// --dart-define=APP_ENV_NAME="stage/stage/prod"

// class EnvironmentConfig {
//   // static const BASE_URL = String.fromEnvironment('APP_BASE_URL');
//   // static const ENV_NAME = String.fromEnvironment('APP_ENV_NAME');
//   // static const MAP_API_KEY = String.fromEnvironment('APP_MAP_API_KEY');
//
//   static AppConfig? _appConfig;
//
//   static bool get isProduction => _appConfig?.flavor == EnvType.prod;
//
//   static AppConfig envType() {
//     AppUtils.log('Calling envType function inside EnvironmentConfig class');
//     const environmentParameter = String.fromEnvironment('ENV');
//     final result = EnvType.values.firstWhere(
//       (element) => element.name == environmentParameter,
//     );
//
//     AppUtils.debugPrint('Passed ENV=($environmentParameter)');
//     AppUtils.debugPrint('Processed EnvType=($result)');
//     if (_appConfig != null) {
//       AppUtils.log(
//           'Finished Calling envType function inside EnvironmentConfig class '
//           'and restoring _appConfig=($_appConfig)');
//       return _appConfig!;
//     }
//     switch (result) {
//       case EnvType.prod:
//         _appConfig = AppConfig(
//           appName: AppStrings.appName,
//           flavor: EnvType.prod,
//           baseUrl: "https://api.kawtharuna.com/v1/",
//         );
//         break;
//       case EnvType.dev:
//       default:
//         _appConfig = AppConfig(
//             appName: '${AppStrings.appName} Dev',
//             flavor: EnvType.dev,
//             baseUrl: 'http://localhost:4200/v1/');
//         break;
//     }
//     AppUtils.debugPrint('_appConfig=($_appConfig)');
//     AppUtils.log(
//         'Finished Calling envType function inside EnvironmentConfig class and build '
//         '_appConfig=($_appConfig)');
//
//     return _appConfig!;
//   }
// }

enum EnvType { prod, dev, none }

// class AppConfig {
//   final String appName;
//   final EnvType flavor;
//   final String baseUrl;
//
//   AppConfig({
//     required this.appName,
//     required this.flavor,
//     required this.baseUrl,
//   });
//
//   factory AppConfig.init() {
//     return AppConfig(
//       appName: '',
//       baseUrl: '',
//       flavor: EnvType.none,
//     );
//   }
//
//   @override
//   String toString() {
//     return '$AppConfig('
//         'appName: $appName, '
//         'flavor: $flavor, '
//         'baseLink: $baseUrl'
//         ')';
//   }
// }
