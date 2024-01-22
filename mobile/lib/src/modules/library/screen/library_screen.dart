import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/constants/app_text_style.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/managers/theme/app_them_manager.dart';
import 'package:kawtharuna/src/core/utils/utl_device.dart';
import 'package:kawtharuna/src/core/widgets/app_bar/salony_app_bar.dart';
import 'package:kawtharuna/src/core/widgets/error/app_error_widget.dart';
import 'package:kawtharuna/src/core/widgets/image/app_image_widget.dart';
import 'package:kawtharuna/src/core/widgets/loader/app_loading_indicator.dart';
import 'package:kawtharuna/src/modules/library/domain/blocs/library_cubit.dart';
import 'package:provider/provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final _bloc = findDep<LibraryCubit>();
  final _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    _bloc.getLibraryFileEntries(
      cancelToken: _cancelToken,
      isRefresh: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return Scaffold(
      backgroundColor: themeStore.appColors.scaffoldBgColor,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: translate.islamic_library,
        // leading: AppMenuIconWidget(
        //   onDrawerPressed: () {
        //     mainKey.currentState?.openDrawer();
        //   },
        // ),
      ),
      body: SizedBox(
          height: DeviceUtils.getScaledHeight(context, 1),
          width: DeviceUtils.getScaledWidth(context, 1),
          child: BlocBuilder<LibraryCubit, LibraryState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state.getLibraryFileEntries is LibraryFileEntriesSuccess) {
                final fileEntries =
                    (state.getLibraryFileEntries as LibraryFileEntriesSuccess)
                        .fileEntries;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  padding: EdgeInsets.all(8.0),
                  itemCount: fileEntries.length,
                  itemBuilder: (context, index) {
                    final file = fileEntries[index];
                    return Column(
                      children: [
                        Expanded(
                          child: AppImageWidget(path: file.thumbnail),
                        ),
                        Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: Text(
                              file.name,
                              style: appTextStyle.semiBold16.copyWith(
                                color: themeStore.appColors.textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
              if (state.getLibraryFileEntries is BaseFailState) {
                final error = state.getLibraryFileEntries as BaseFailState;
                return AppErrorWidget(errorState: error);
              }
              return AppLoader();
            },
          )

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          //     Text(
          //       'No files yet, will be added soon.',
          //       style: appTextStyle.medium18.copyWith(
          //         color: themeStore.appColors.textColor,
          //       ),
          //     )
          //   ],
          // ),
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }
}
