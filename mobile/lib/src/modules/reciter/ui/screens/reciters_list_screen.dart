// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/generated_files/assets/assets.gen.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/app_bar/empty_app_bar_widget.dart';
import 'package:kawtharuna/src/core/widgets/audio/app_player.dart';
import 'package:kawtharuna/src/core/widgets/icons/app_menu_icon_widget.dart';
import 'package:kawtharuna/src/modules/main_menu/screens/main_menu_screen.dart';
import 'package:kawtharuna/src/modules/reciter/domain/blocs/reciters_cubit.dart';

import '../../domain/entity/reciter_entity.dart';

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

  /// A new string is uploaded to storage.
  Future<Reference> uploadString() async {
    const String putStringText =
        'This upload has been generated using the putString method! Check the metadata too!';

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref('/images')
        .child('/reciters')
        .child('/Maher_Al_Mueaqly')
        .child('/1');

    // Start upload of putString
    await ref.putFile(
      await getImageFileFromAssets(Assets.reciters.maherAlMueaqly.path),
      SettableMetadata(
        contentLanguage: 'ar',
        customMetadata: <String, String>{
          'number': '1',
        },
      ),
    );
    return ref;
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return Scaffold(
      backgroundColor: themeStore.appColors.scaffoldBgColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // final result = await uploadString();
            // print('result is $result - ${await result.getDownloadURL()}');
          } catch (e) {
            print('error is $e');
          }
          await _bloc.createReciter(
            reciter: ReciterEntity(
              id: '',
              image:
                  'https://firebasestorage.googleapis.com/v0/b/qurany-b3020.appspot.com/o/images%2Freciters%2FAbdul_Rahman_Al-Sudais%2Falsudais.jpeg?alt=media&token=1a1b52c7-12c5-447b-aae9-0c8a3fb47e0d',
              name: LocalizedEntity(
                ar: 'عبد الرحمن السديس',
                en: 'Abdul Rahman Al-Sudais',
              ),
              numberOfSeals: 0,
              bio: LocalizedEntity(
                ar: 'hello',
                en: 'hello',
              ),
              totalNumberOfPlay: 0,
              totalNumberOfDownload: 0,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: CustomAppBar(
        titleString: translate.reciters,
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
