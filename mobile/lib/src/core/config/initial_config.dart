import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:kawtharuna/src/core/config/env_variables.dart';
// import 'package:salon_app/core/config/env_variables.dart';
// import 'package:salon_app/core/constants/app_endpoints.dart';
// import 'package:salon_app/core/constants/app_strings.dart';
// import 'package:salon_app/core/di/injector.dart';
// import 'package:salon_app/core/helpers/bloc_observer.dart';
// import 'package:salon_app/core/managers/analytics/service/mixpanel_analytics_service.dart';
// import 'package:salon_app/core/managers/firebase_messaging/firebase_messaging_api.dart';
// import 'package:salon_app/core/managers/localization/app_language.dart';
// import 'package:salon_app/core/managers/notification/notification_api.dart';
// import 'package:salon_app/core/utils/error_logger.dart';
// import 'package:salon_app/main_prod.dart';

Future<void> initConfig() async {
  await Firebase.initializeApp();
  EnvVariables.initiateVariables();
  await Future.wait(
    [
      _setUpAllEnvVar(),
      // configureDependencies(),
      setPreferredOrientations(),
      // NotificationApi.init(),
    ],
  );

  // FirebaseMessaging.onBackgroundMessage(onDidReceiveBackgroundMessage);
  //
  // Bloc.observer = SimpleBlocObserver();
  EquatableConfig.stringify = kDebugMode;
  // isRelease = !kDebugMode;

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  // await findDep<MixPanelAnalyticsService>()
  //     .initMixpanel(AppStrings.mixpanelKeyToken);

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = (errorDetails) {
    // ErrorLogger.logError(
    //   errorDetails.exception,
    //   errorDetails.stack,
    //   recordFirebase: false,
    // );
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   // ErrorLogger.logError(error, stack);
  //   return true;
  // };

  // await findDep<AppLanguageManager>().fetchLocale();
}

Future<void> _setUpAllEnvVar() async {
  // AppEndpoints.baseUrl = EnvVariables.apiURL;
  // AppStrings.mixpanelKeyToken = EnvVariables.mixpanelKeyToken;
  // AppStrings.appName = EnvVariables.appName;
  // Stripe.publishableKey = EnvVariables.stripePublishableKey;
  // Stripe.merchantIdentifier = EnvVariables.stripeMerchantIdentifier;
  // Stripe.stripeAccountId = EnvVariables.stripeAccountId;
  // await Stripe.instance.applySettings();

  // Stripe.urlScheme = 'flutterstripe';
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
