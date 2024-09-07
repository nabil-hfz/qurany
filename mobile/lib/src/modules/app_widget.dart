import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kawtharuna/main.dart';
import 'package:kawtharuna/src/core/config/env_variables.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/ads/ads_controller.dart';
import 'package:kawtharuna/src/core/managers/app_lifecycle/app_lifecycle.dart';
import 'package:kawtharuna/src/core/managers/audio/audio_controller.dart';
import 'package:kawtharuna/src/core/managers/games_services/games_services.dart';
import 'package:kawtharuna/src/core/managers/in_app_purchase/in_app_purchase.dart';
import 'package:kawtharuna/src/core/managers/localization/generated/l10n.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/managers/player_progress/persistence/player_progress_persistence.dart';
import 'package:kawtharuna/src/core/managers/player_progress/player_progress.dart';
import 'package:kawtharuna/src/core/managers/settings/persistence/settings_persistence.dart';
import 'package:kawtharuna/src/core/managers/settings/settings.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // static final _router = navigator.buildRouter();

  final PlayerProgressPersistence playerProgressPersistence;

  final SettingsPersistence settingsPersistence;

  final GamesServicesController? gamesServicesController;

  final InAppPurchaseController? inAppPurchaseController;

  final AdsController? adsController;

  const MyApp({
    required this.playerProgressPersistence,
    required this.settingsPersistence,
    required this.inAppPurchaseController,
    required this.adsController,
    required this.gamesServicesController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final router = navigator.router;
    final appTheme = findDep<AppThemeManager>();
    final appLanguageManager = findDep<AppLanguageManager>();
    return AppLifecycleObserver(
      child: Builder(builder: (context) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => appLanguageManager),
            ChangeNotifierProvider(create: (_) => appTheme),
            ChangeNotifierProvider(
              create: (context) {
                var progress = PlayerProgress(playerProgressPersistence);
                progress.getLatestFromStore();
                return progress;
              },
            ),
            Provider<GamesServicesController?>.value(
                value: gamesServicesController),
            Provider<AdsController?>.value(value: adsController),
            ChangeNotifierProvider<InAppPurchaseController?>.value(
              value: inAppPurchaseController,
            ),
            Provider<SettingsController>(
              lazy: false,
              create: (context) => SettingsController(
                persistence: settingsPersistence,
              )..loadStateFromPersistence(),
            ),
            ProxyProvider2<SettingsController, ValueNotifier<AppLifecycleState>,
                AudioController>(
              // Ensures that the AudioController is created on startup,
              // and not "only when it's needed", as is default behavior.
              // This way, music starts immediately.
              lazy: false,
              create: (context) => findDep<AudioController>(),
              update: (context, settings, lifecycleNotifier, audio) {
                if (audio == null) throw ArgumentError.notNull();
                audio.attachSettings(settings);
                audio.attachLifecycleNotifier(lifecycleNotifier);
                return audio;
              },
              dispose: (context, audio) => audio.dispose(),
            ),
            // Provider(
            //   create: (context) => Palette(),
            // ),
          ],
          child: Consumer<AppLanguageManager>(
            builder: (context, appLanguage, child) {
              return Consumer<AppThemeManager>(
                builder: (context, appTheme, _) {
                  return MaterialApp.router(
                    builder: (context, widget) => AnnotatedRegion(
                      value: appTheme.systemUiOverlayStyle,
                      child: widget!,
                    ),
                    locale: appLanguage.appLocal,
                    debugShowCheckedModeBanner: false,
                    theme: appTheme.getLightTheme,
                    darkTheme: appTheme.getDarkTheme,
                    themeMode: appTheme.getThemeMode,

                    title: EnvVariables.appName,

                    supportedLocales: Translations.delegate.supportedLocales,
                    localeResolutionCallback: (locale, supportedLocales) {
                      return locale;
                    },
                    localizationsDelegates: const [
                      Translations.delegate,
                      // RefreshLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    // Navigation Settings
                    routerConfig: navigator.router,
                    // routerDelegate: router.routerDelegate,
                    // routeInformationParser: router.routeInformationParser,
                    // routeInformationProvider: router.routeInformationProvider,
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
