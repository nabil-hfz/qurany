import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
// import 'package:provider/provider.dart';
// import 'package:kawtharuna/src/core/managers/games_services/score.dart';
// import 'package:kawtharuna/src/core/style/my_transition.dart';
// import 'package:kawtharuna/src/core/style/palette.dart';
// import 'package:kawtharuna/src/modules/level_selection/level_selection_screen.dart';
// import 'package:kawtharuna/src/modules/level_selection/levels.dart';
// import 'package:kawtharuna/src/modules/main_menu/screens/reciter_screen.dart';
// import 'package:kawtharuna/src/modules/play_session/play_session_screen.dart';
// import 'package:kawtharuna/src/modules/settings/settings_screen.dart';
// import 'package:kawtharuna/src/modules/win_game/win_game_screen.dart';

@Singleton()
class AppNavigator {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  AppNavigator();

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
// GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

// final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

// Future<T?> pushNamed<T>(String routeName, {dynamic arguments}) {
//   DeviceUtils.hideKeyboard(_navigatorKey.currentContext!);
//   return _navigatorKey.currentState!
//       .pushNamed<T>(routeName, arguments: arguments);
// }
//
// Future<T?> pushReplacementNamed<T>(String routeName, {dynamic arguments}) {
//   DeviceUtils.hideKeyboard(_navigatorKey.currentContext!);
//   return _navigatorKey.currentState!
//       .pushReplacementNamed(routeName, arguments: arguments);
// }
//
// Future<T?> pushNamedAndRemoveUntil<T>(String routeName, {Object? arguments}) {
//   DeviceUtils.hideKeyboard(_navigatorKey.currentContext!);
//   return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
//     routeName,
//     (Route<dynamic> route) => false,
//     arguments: arguments,
//   );
// }
//
// void pop<T>([T? result]) {
//   DeviceUtils.hideKeyboard(_navigatorKey.currentContext!);
//   return _navigatorKey.currentState!.pop(result);
// }
//
// bool canPop() {
//   return _navigatorKey.currentState!.canPop();
// }
//
// Future<T?> offAll<T>(String routeName, {dynamic arguments, T? result}) {
//   DeviceUtils.hideKeyboard(_navigatorKey.currentContext!);
//   return _navigatorKey.currentState!.pushNamedAndRemoveUntil<T>(
//     routeName,
//     (route) => false,
//   );
// }
//
// void pushNamedIfNotCurrent(
//   String routeName, {
//   Object? arguments,
// }) {
//   if (!isCurrent(routeName)) {
//     pushNamed(routeName, arguments: arguments);
//   }
// }
//
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
//
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
//
// Future? goRoot() {
//   /// TODO
//   return null;
// }
//
// Future? goLogin() {
//   /// TODO
//   return null;
// }
}
