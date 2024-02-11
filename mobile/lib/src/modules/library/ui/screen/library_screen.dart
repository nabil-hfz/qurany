import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/constants/app_dimens.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/managers/theme/app_them_manager.dart';
import 'package:kawtharuna/src/core/utils/utl_device.dart';
import 'package:kawtharuna/src/core/widgets/app_bar/salony_app_bar.dart';
import 'package:kawtharuna/src/core/widgets/common/refresh_wrapper.dart';
import 'package:kawtharuna/src/core/widgets/error/app_error_widget.dart';
import 'package:kawtharuna/src/core/widgets/loader/app_loading_indicator.dart';
import 'package:kawtharuna/src/modules/library/domain/blocs/library_cubit.dart';
import 'package:kawtharuna/src/modules/library/domain/entity/library_entity.dart';
import 'package:kawtharuna/src/modules/library/ui/widgets/file_entry_item_list_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    _onRefresh(null);
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager appTheme = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    final height = DeviceUtils.getScaledHeight(context, 1);
    final width = DeviceUtils.getScaledWidth(context, 1);
    return Scaffold(
      backgroundColor: appTheme.appColors.scaffoldBgColor,
      appBar: CustomAppBar(
        automaticallyImplyLeading: false,
        title: translate.islamic_library,
        // actions: [AppIconButton.download(onPressed: () {})],
      ),
      body: SizedBox(
        height: height,
        width: width,
        child: BlocBuilder<LibraryCubit, LibraryState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state.getLibraryFileEntries is LibraryFileEntriesSuccess) {
              final fileEntries =
                  (state.getLibraryFileEntries as LibraryFileEntriesSuccess)
                      .fileEntries;

              return RefreshWrapper(
                enablePullUp: true,
                enablePullDown: true,
                withInitialRefresh: false,
                // onControllerInitiated: (RefreshControllerHandler controller) {
                //   // _controller.add(controller);
                // },
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 5 / 9,
                    // mainAxisExtent: 390,
                  ),
                  padding: EdgeInsets.all(AppDimens.space8),
                  itemCount: fileEntries.length,
                  itemBuilder: (context, index) {
                    final file = fileEntries[index];
                    return FileEntryItemListWidget(file: file);
                  },
                ),
              );
            }
            if (state.getLibraryFileEntries is BaseFailState) {
              final error = state.getLibraryFileEntries as BaseFailState;
              return AppErrorWidget(errorState: error);
            }
            return AppLoader();
          },
        ),
      ),
    );
  }

  Future<void> _onLoading([RefreshControllerHandler? controller]) {
    return _bloc.getLibraryFileEntries(
      controller: controller,
      cancelToken: _cancelToken,
      isRefresh: false,
    );
  }

  Future<void> _onRefresh([RefreshControllerHandler? controller]) {
    return _bloc.getLibraryFileEntries(
      controller: controller,
      cancelToken: _cancelToken,
      isRefresh: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }
}

class PdfViewPage extends StatelessWidget {
  const PdfViewPage({required this.args, super.key});

  final FileEntryEntity args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: args.name),
      body: SfPdfViewer.network(args.file),
    );
  }
}
