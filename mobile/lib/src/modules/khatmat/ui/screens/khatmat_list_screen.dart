import 'dart:async';
import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/generated_files/assets/assets.gen.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/app_bar/empty_app_bar_widget.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/core/widgets/icons/app_menu_icon_widget.dart';
import 'package:kawtharuna/src/modules/main_menu/screens/main_menu_screen.dart';
import 'package:kawtharuna/src/modules/reciter/domain/blocs/reciter_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class RecitersListScreen extends StatefulWidget {
  const RecitersListScreen({super.key});

  @override
  State<RecitersListScreen> createState() => _RecitersListScreenState();
}

class _RecitersListScreenState extends State<RecitersListScreen> {
  final _bloc = findDep<ReciterCubit>();

  @override
  void initState() {
    super.initState();

    _onRefresh();
  }

  Future<File> getImageFileFromAssets(String path) async {
    final Directory docDir = await getApplicationDocumentsDirectory();
    final String localPath = docDir.path;
    File file = File('$localPath/${path.split('/').last}');
    final imageBytes = await rootBundle.load(path);
    final buffer = imageBytes.buffer;
    return await file.writeAsBytes(
        buffer.asUint8List(imageBytes.offsetInBytes, imageBytes.lengthInBytes));
    // final byteData = await rootBundle.load(path);

    // final file = File('${(await getTemporaryDirectory()).path}/$path');
    // await file.writeAsBytes(byteData.buffer
    //     .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    // return file;
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: translate.reciters,
        leading: AppMenuIconWidget(
          onDrawerPressed: () {
            mainKey.currentState?.openDrawer();
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ReciterCubit, ReciterState>(
        bloc: _bloc,
        listener: (context, state) {},
        builder: (context, state) {
          final recitersState = state.getReciters;
          if (recitersState is BaseFailState) {
            return Text(
              'Failed to get the list',
              style: appTextStyle.medium18.copyWith(
                color: themeStore.appColors.textErrorColor,
              ),
            );
          }
          if (recitersState is RecitersSuccess) {
            final reciters = recitersState.reciters;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  for (var reciter in reciters)
                    AudioListTile(
                      reciter: reciter,
                      onTap: () {
                        currentlyPlaying.value = reciter;
                      },
                    ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      // ResponsiveScreen(
      //   mainAreaProminence: 1.8,
      //   squarishMainArea: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       for (AudioObject audioObject in audioExamples)
      //         AudioListTile(
      //           audioObject: audioObject,
      //           onTap: () {
      //             currentlyPlaying.value = audioObject;
      //           },
      //         ),
      //     ],
      //   ),
      //   rectangularMenuArea: Container(),
      // ),
    );
  }

  // Prevents the game from showing game-services-related menu items
  // until we're sure the player is signed in.
  //
  // This normally happens immediately after game start, so players will not
  // see any flash. The exception is folks who decline to use Game Center
  // or Google Play Game Services, or who haven't yet set it up.
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

  Future<void> _onRefresh() {
    return _bloc.getReciters(isRefresh: true);
  }
}
