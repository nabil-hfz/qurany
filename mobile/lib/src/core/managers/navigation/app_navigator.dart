// Flutter imports:
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/main.dart';
import 'package:kawtharuna/src/core/managers/navigation/app_navigation_arg.dart';
import 'package:kawtharuna/src/core/managers/navigation/nav_routes.dart';
import 'package:kawtharuna/src/core/utils/utl_device.dart';
import 'package:kawtharuna/src/core/widgets/error/not_found_screen.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';
import 'package:kawtharuna/src/modules/khatmat/ui/screens/khatma_details_screen.dart';
import 'package:kawtharuna/src/modules/library/domain/entity/library_entity.dart';
import 'package:kawtharuna/src/modules/library/ui/screen/library_screen.dart';
import 'package:kawtharuna/src/modules/main/screens/main_screen.dart';
import 'package:kawtharuna/src/modules/spalsh/ui/pages/splash_screen.dart';

@Singleton()
class AppNavigator {
  AppNavigator();

  GlobalKey<NavigatorState> get navigatorKey => AppRouter._navigatorKey;

  GoRouter get router => AppRouter._router;

  Future<Object?> pushNamed(
    String routeName, {
    dynamic arguments,
  }) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    return router.pushNamed(routeName, extra: arguments);
    // _navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  void go<T>(String routeName, {dynamic arguments}) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    router.go(routeName, extra: arguments);
    // _navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  void goNamed<T>(
    String routeName, {
    dynamic arguments,
    required Map<String, String> pathParameters,
  }) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    router.goNamed(
      routeName,
      extra: arguments,
      pathParameters: pathParameters,
    );
    // _navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }

  void pushReplacementNamed<T>(String routeName, {dynamic arguments}) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    router.pushReplacementNamed(routeName, extra: arguments);

    // _navigatorKey.currentState!
    //     .pushReplacementNamed(routeName, arguments: arguments);
  }

  void pushNamedAndRemoveUntil(String routeName, {Object? arguments}) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    while (router.canPop()) {
      router.pop();
    }
    router.pushReplacementNamed(routeName, extra: arguments);

    // _navigatorKey.currentState!.pushNamedAndRemoveUntil(
    //   routeName,
    //   (Route<dynamic> route) => false,
    //   arguments: arguments,
    // );
  }

  void pop<T>([T? result]) {
    DeviceUtils.hideKeyboard(navigatorKey.currentContext!);
    if (canPop()) router.pop(result);
    // return _navigatorKey.currentState!.pop(result);
  }

  bool canPop() {
    return router.canPop();
    // return _navigatorKey.currentState!.canPop();
  }
}

abstract class AppRouter {
  static const ValueKey<String> _scaffoldKey = ValueKey<String>('App scaffold');

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  // GoRouter buildRouter() {
  //   return GoRouter(
  //     routes: [
  //       GoRoute(
  //         path: '/',
  //         builder: (context, state) =>
  //             const MainMenuScreen(key: Key('main menu')),
  //         routes: [
  //           GoRoute(
  //             path: 'play',
  //             pageBuilder: (context, state) => buildMyTransition<void>(
  //               child: const LevelSelectionScreen(
  //                 key: Key('level selection'),
  //               ),
  //               color: context.watch<Palette>().backgroundLevelSelection,
  //             ),
  //             routes: [
  //               GoRoute(
  //                 path: 'session/:level',
  //                 pageBuilder: (context, state) {
  //                   final levelNumber = int.parse(state.params['level']!);
  //                   final level =
  //                       gameLevels.singleWhere((e) => e.number == levelNumber);
  //                   return buildMyTransition<void>(
  //                     child: PlaySessionScreen(
  //                       level,
  //                       key: const Key('play session'),
  //                     ),
  //                     color: context.watch<Palette>().backgroundPlaySession,
  //                   );
  //                 },
  //               ),
  //               GoRoute(
  //                 path: 'won',
  //                 pageBuilder: (context, state) {
  //                   final map = state.extra! as Map<String, dynamic>;
  //                   final score = map['score'] as Score;
  //
  //                   return buildMyTransition<void>(
  //                     child: WinGameScreen(
  //                       score: score,
  //                       key: const Key('win game'),
  //                     ),
  //                     color: context.watch<Palette>().backgroundPlaySession,
  //                   );
  //                 },
  //               )
  //             ],
  //           ),
  //           GoRoute(
  //             path: 'settings',
  //             builder: (context, state) =>
  //                 const SettingsScreen(key: Key('settings')),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  static final GoRouter _router = GoRouter(
    navigatorKey: _navigatorKey,
    routes: <GoRoute>[
      GoRoute(
        name: Routes.root,
        path: Routes.root,
        redirect: (context, state) => Routes.splash,
      ),
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        pageBuilder: (context, state) {
          const child = SplashScreen();
          return pageBuilder(context, state, child);
        },
      ),

      GoRoute(
        name: Routes.homeScreen,
        path: Routes.homeScreen,
        pageBuilder: (context, state) {
          const child = MainMenuScreen();
          return pageBuilder(context, state, child, key: _scaffoldKey);
        },
      ),
      GoRoute(
        name: Routes.pdfViewScreen,
        path: Routes.pdfViewScreen,
        pageBuilder: (context, state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as FileEntryEntity;

          final child = PdfViewPage(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.khatmaDetailsScreen,
        path: Routes.khatmaDetailsScreen,
        pageBuilder: (context, state) {
          var navArgs = state.extra as BaseNavigationArg;
          var args = navArgs.data as KhatmaEntity;

          final child = KhatmaDetailsScreen(args: args);
          return pageBuilder(context, state, child);
        },
      ),
      // GoRoute(
      //   name: Routes.catalogueScreen,
      //   path: Routes.catalogueScreen,
      //   redirect: (_, __) => Routes.catalogueServicesScreen,
      // ),
    ],

    // redirect: _guard,
    // refreshListenable: _auth,
    debugLogDiagnostics: !isProduction,
    // debugLogDiagnostics: true,
    // debugLogDiagnostics: true,
  );

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundScreen();

  static Page pageBuilder(
    BuildContext context,
    GoRouterState state,
    Widget child, {
    LocalKey? key,
    BaseNavigationArg? navArgs,
  }) {
    if (navArgs != null) {
      if (navArgs.navigationType == NavigationType.slideVertical) {
        return VerticalSlideTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.slideHorizontalLeft) {
        return HorizontalSlideLeftTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.slideHorizontalRight) {
        return HorizontalSlideRightTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.fadeScale) {
        return FadeScaleTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.fadeThrough) {
        return FadeThroughTransitionPage(
          key: key ?? state.pageKey,
          child: child,
        );
      }
      if (navArgs.navigationType == NavigationType.sharedAxisTransition) {
        return SharedAxisTransitionPage(
          child: child,
          key: key ?? state.pageKey,
          transitionType: SharedAxisTransitionType.horizontal,
        );
      }
    }

    return FadeTransitionPage(
      key: key ?? state.pageKey,
      child: child,
    );
  }
}

class FadeTransitionPage extends CustomTransitionPage<void> {
  /// Creates a [FadeTransitionPage].
  FadeTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation.drive(_curveTween),
            child: child,
          ),
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
}

class VerticalSlideTransitionPage extends CustomTransitionPage<void> {
  VerticalSlideTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: _offsetTween.chain(_curveTween).animate(animation),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
  static final Tween<Offset> _offsetTween = Tween(
    begin: const Offset(0, 1),
    end: const Offset(0, 0),
  );
}

class HorizontalSlideLeftTransitionPage extends CustomTransitionPage<void> {
  HorizontalSlideLeftTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: _leftOffsetTween.chain(_curveTween).animate(animation),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
  static final Tween<Offset> _leftOffsetTween = Tween(
    begin: const Offset(1, 0),
    end: const Offset(0, 0),
  );
}

class HorizontalSlideRightTransitionPage extends CustomTransitionPage<void> {
  HorizontalSlideRightTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: _rightOffsetTween.chain(_curveTween).animate(animation),
              child: child,
            );
          },
        );

  static final CurveTween _curveTween = CurveTween(curve: Curves.easeIn);
  static final Tween<Offset> _rightOffsetTween = Tween(
    begin: const Offset(-1, 0),
    end: const Offset(0, 0),
  );
}

class FadeScaleTransitionPage extends CustomTransitionPage<void> {
  FadeScaleTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeScaleTransition(
              animation: animation,
              child: child,
              // secondaryAnimation: secondaryAnimation,
            );
          },
        );
}

class FadeThroughTransitionPage extends CustomTransitionPage<void> {
  FadeThroughTransitionPage({
    required LocalKey super.key,
    required super.child,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
        );
}

class SharedAxisTransitionPage extends CustomTransitionPage<void> {
  final SharedAxisTransitionType transitionType;

  SharedAxisTransitionPage({
    required LocalKey super.key,
    required super.child,
    required this.transitionType,
  }) : super(
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: transitionType,
              child: child,
            );
          },
        );
}
