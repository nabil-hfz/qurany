import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_strings.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/modules/khatmat/ui/screens/khatmat_list_screen.dart';
import 'package:kawtharuna/src/modules/library/ui/screen/library_screen.dart';
import 'package:kawtharuna/src/modules/main/widgets/app_bottom_navigation_bar.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

final _navigatorKey = GlobalKey<NavigatorState>();
ValueNotifier<int> currentIndex = ValueNotifier(0);
final mainKey = GlobalKey<ScaffoldState>();

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final gamesServicesController = context.watch<GamesServicesController?>();
    // final settingsController = context.watch<SettingsController>();
    // final audioController = context.watch<AudioController>();
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    return MiniplayerWillPopScope(
      onWillPop: () async {
        final NavigatorState? navigator = _navigatorKey.currentState;
        if (!navigator!.canPop()) return true;
        navigator.pop();

        return false;
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Text('here'),
          onPressed: () {
            try {
              if (themeStore.isDarkMode) {
                themeStore.toggleTheme(ThemeMode.light);
              } else {
                themeStore.toggleTheme(ThemeMode.dark);
              }
            } catch (e) {
              print("error is $e");
            }
            // appTheme.onChange(themeMode)
          },
        ),
        backgroundColor: themeStore.appColors.scaffoldBgColor,
        key: mainKey,
        drawer: Drawer(
          backgroundColor: themeStore.appColors.scaffoldBgColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: themeStore.appColors.primaryColor,
                ),
                child: Text(
                  'Welcome to ${AppStrings.appName}',
                  style: appTextStyle.medium24.copyWith(
                    color: themeStore.appColors.textColor,
                  ),
                ),
              ),
              // ListTile(
              //   leading: Icon(Icons.message),
              //   title: Text('Messages'),
              // ),
              // ListTile(
              //   leading: Icon(Icons.account_circle),
              //   title: Text('Profile'),
              // ),
              ListTile(
                onTap: () {
                  // Manager
                  // Scaffold.of(context)
                },
                leading: Icon(
                  Icons.settings,
                  color: themeStore.appColors.iconColor,
                ),
                title: Text(
                  translate.settings,
                  style: appTextStyle.medium16.copyWith(
                    color: themeStore.appColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNavigationBar(),
        body: Stack(
          children: <Widget>[
            Column(
              children: [
                Expanded(
                  child: Navigator(
                    key: _navigatorKey,
                    onGenerateRoute: (settings) => MaterialPageRoute(
                      settings: settings,
                      builder: (context) => ValueListenableBuilder(
                        valueListenable: currentIndex,
                        builder: (context, index, child) {
                          return IndexedStack(
                            index: index,
                            children: const [
                              KhatmatListScreen(),
                              LibraryScreen(),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
                BottomPaddingAsMiniPlayer(),
              ],
            ),
            DetailedPlayer(),
          ],
        ),
      ),
    );
  }

  /// Prevents the game from showing game-services-related menu items
  /// until we're sure the player is signed in.
  ///
  /// This normally happens immediately after game start, so players will not
  /// see any flash. The exception is folks who decline to use Game Center
  /// or Google Play Game Services, or who haven't yet set it up.
  Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
    return FutureBuilder<bool>(
      future: ready,
      builder: (context, snapshot) {
        // Use Visibility here so that we have the space for the buttons
        // ready.
        return Visibility(
          visible: snapshot.data ?? false,
          maintainState: true,
          maintainSize: true,
          maintainAnimation: true,
          child: child,
        );
      },
    );
  }

// static const _gap = SizedBox(height: 10);
}

// const Set<AudioObject> audioExamples = {
//   AudioObject('Salt & Pepper', 'Dope Lemon',
//       'https://m.media-amazon.com/images/I/81UYWMG47EL._SS500_.jpg'),
//   AudioObject('Losing It', 'FISHER',
//       'https://m.media-amazon.com/images/I/9135KRo8Q7L._SS500_.jpg'),
//   AudioObject('American Kids', 'Kenny Chesney',
//       'https://cdn.playbuzz.com/cdn/7ce5041b-f9e8-4058-8886-134d05e33bd7/5c553d94-4aa2-485c-8a3f-9f496e4e4619.jpg'),
//   AudioObject('Wake Me Up', 'Avicii',
//       'https://upload.wikimedia.org/wikipedia/en/d/da/Avicii_Wake_Me_Up_Official_Single_Cover.png'),
//   AudioObject('Missing You', 'Mesto',
//       'https://img.discogs.com/EcqkrmOCbBguE3ns-HrzNmZP4eM=/fit-in/600x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-12539198-1537229070-5497.jpeg.jpg'),
//   AudioObject('Drop it dirty', 'Tavengo',
//       'https://images.shazam.com/coverart/t416659652-b1392404277_s400.jpg'),
//   AudioObject('Cigarettes', 'Tash Sultana',
//       'https://m.media-amazon.com/images/I/91vBpel766L._SS500_.jpg'),
//   AudioObject('Ego Death', 'Ty Dolla \$ign, Kanye West, FKA Twigs, Skrillex',
//       'https://static.stereogum.com/uploads/2020/06/Ego-Death-1593566496.jpg'),
// };
