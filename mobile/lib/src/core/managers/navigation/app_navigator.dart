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
import 'package:kawtharuna/src/modules/main_menu/screens/main_menu_screen.dart';
import 'package:kawtharuna/src/modules/main_menu/screens/not_found_page.dart';
import 'package:kawtharuna/src/modules/spalsh/ui/pages/splash_page.dart';

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

// offAll<T>(String routeName, {dynamic arguments, T? result}) {
//   DeviceUtils.hideKeyboard(_navigatorKey.currentContext!);
//   _navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
//     routeName,
//     (route) => false,
//   );
// }

// void pushNamedIfNotCurrent(
//   String routeName, {
//   Object? arguments,
// }) {
//   if (!isCurrent(routeName)) {
//     pushNamed(routeName, arguments: arguments);
//   }
// }

// void pushReplacementNamedIfNotCurrent(
//   String routeName, {
//   Object? arguments,
// }) {
//   if (!isCurrent(routeName)) {
//     pushReplacementNamed(
//       routeName,
//       arguments: arguments,
//     );
//   }
// }

// bool isCurrent(String routeName) {
//   bool isCurrent = false;
//   _navigatorKey.currentState!.popUntil((route) {
//     if (route.settings.name == routeName) {
//       isCurrent = true;
//     }
//     return true;
//   });
//   return isCurrent;
// }
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
          const child = SplashPage();
          return pageBuilder(context, state, child);
        },
      ),
      GoRoute(
        name: Routes.mainRootPage,
        path: Routes.mainRootPage,
        redirect: (context, state) => Routes.homePage,
      ),

      /// Main management.
      GoRoute(
        name: Routes.homePage,
        path: Routes.homePage,
        pageBuilder: (context, state) {
          const child = MainMenuScreen(key: Key('main menu'));
          return pageBuilder(context, state, child, key: _scaffoldKey);
        },
      ),
      GoRoute(
        name: Routes.cataloguePage,
        path: Routes.cataloguePage,
        redirect: (_, __) => Routes.catalogueServicesPage,
      ),
      // GoRoute(
      //   name: Routes.catalogueKindPage,
      //   path: Routes.catalogueKindPage,
      //   pageBuilder: (context, state) {
      //     var kind = state.pathParameters['kind']!;
      //     final child = MainRootPage(
      //       currentTab: CurrentTab.catalog,
      //       child: CataloguePage(kind),
      //     );
      //     return pageBuilder(context, state, child, key: _scaffoldKey);
      //   },
      //   routes: <GoRoute>[
      //     GoRoute(
      //       path: ':packageId',
      //       builder: (context, state) {
      //         var navArgs = state.extra as BaseNavigationArg;
      //         var args = navArgs.data as PackageDetailsArgs;
      //
      //         return PackageDetails(args: args);
      //       },
      //     ),
      //   ],
      // ),
      // GoRoute(
      //   name: Routes.clientsPage,
      //   path: Routes.clientsPage,
      //   pageBuilder: (BuildContext context, GoRouterState state) {
      //     final child = MainRootPage(
      //       currentTab: CurrentTab.booking,
      //       child: Text(Translations.of(context).clients),
      //     );
      //     return pageBuilder(context, state, child, _scaffoldKey);
      //   },
      // ),

      // GoRoute(
      //   name: Routes.bookingDetailsPage,
      //   path: Routes.bookingDetailsPage,
      //   pageBuilder: (BuildContext context, GoRouterState state) {
      //     var navArgs = state.extra as BaseNavigationArg;
      //     var args = navArgs.data as BookingDetailsArgs;
      //
      //     final child = BookingDetails(args: args);
      //     return pageBuilder(context, state, child);
      //   },
      // ),

      // GoRoute(
      //   name: Routes.addBookingPage,
      //   path: Routes.addBookingPage,
      //   pageBuilder: (BuildContext context, GoRouterState state) {
      //     var navArgs = state.extra as BaseNavigationArg;
      //     var args = navArgs.data as AddBookingArgs;
      //
      //     final child = AddBookingPage(args: args);
      //     return pageBuilder(context, state, child);
      //   },
      // ),
    ],

    // redirect: _guard,
    // refreshListenable: _auth,
    debugLogDiagnostics: !isProduction,
    // debugLogDiagnostics: true,
    // debugLogDiagnostics: true,
  );

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundPage();

  // static String? _guard(BuildContext context, GoRouterState state) {
  //   final bool signedIn = false; //_auth.signedIn;
  //   final bool signingIn = state.matchedLocation == '/signin';
  //
  //   // Go to /signin if the user is not signed in
  //   if (!signedIn && !signingIn) {
  //     return '/signin';
  //   }
  //   // Go to /books if the user is signed in and tries to go to /signin.
  //   else if (signedIn && signingIn) {
  //     return '/books';
  //   }
  //
  //   // no redirect
  //   return null;
  // }

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
//
// // all the route paths. So that we can access them easily  across the app
//   static const root = '/';
// // static const singleArticle = '/article';
//
//   static mainPage([CurrentTab? type]) => '/${type?.name ?? ':type'}';
// // static const singleArticleWithParams = '/article/:id';
//   /// get route name with parameters, here [id] is optional because we need [:id] to define path on [_singleArticleWithParams]
//   static singleArticleWithParams([String? id]) => '/article/${id ?? ':id'}';
//
//   /// private static methods that are accessible only in this class and not from outside
//   static Widget _mainPageRouteBuilder(
//           BuildContext context, GoRouterState state) =>
//       MainRootPage(
//           currentTab: state.params['type']! == CurrentTab.blogs.name
//               ? CurrentTab.blogs
//               : CurrentTab.favorite);
//
//   static Widget _singleBlog(BuildContext context, GoRouterState state) =>
//       SingleArticle(blog: state.extra as Blog);
//   static Widget _singleArticleWithParams(
//           BuildContext context, GoRouterState state) =>
//       SingleArticleWithParams(id: state.params["id"]!);
//
//   static Widget errorWidget(BuildContext context, GoRouterState state) =>
//       const NotFoundPage();
//
//   /// use this in [MaterialApp.router]
//   static final GoRouter _router = GoRouter(
//     routes: <GoRoute>[
//       GoRoute(
//           path: root,
//           redirect: (context, state) => mainPage(CurrentTab.calendar)),
//       GoRoute(path: mainPage(), builder: _mainPageRouteBuilder),
//       // GoRoute(path: singleArticle, builder: _singleBlog),
//       GoRoute(
//           path: singleArticleWithParams(), builder: _singleArticleWithParams)
//     ],
//     errorBuilder: errorWidget,
//   );
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
