import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_state.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/widgets/app_bar/salony_app_bar.dart';
import 'package:kawtharuna/src/core/widgets/error/app_error_widget.dart';
import 'package:kawtharuna/src/core/widgets/icons/app_menu_icon_widget.dart';
import 'package:kawtharuna/src/core/widgets/loader/app_loading_indicator.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/blocs/khatma_cubit.dart';
import 'package:kawtharuna/src/modules/khatmat/ui/widgets/katma_list_time.dart';
import 'package:kawtharuna/src/modules/main/screens/main_screen.dart';
import 'package:provider/provider.dart';

class KhatmatListScreen extends StatefulWidget {
  const KhatmatListScreen({super.key});

  @override
  State<KhatmatListScreen> createState() => _KhatmatListScreenState();
}

class _KhatmatListScreenState extends State<KhatmatListScreen> {
  final _bloc = findDep<KhatmaCubit>();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(
      context,
      listen: true,
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: translate.home,
        leading: AppMenuIconWidget(
          onDrawerPressed: () {
            mainKey.currentState?.openDrawer();
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<KhatmaCubit, KhatmaState>(
        bloc: _bloc,
        listener: (context, state) {},
        builder: (context, state) {
          final khatmatState = state.getKhatmat;
          return _buildBody(khatmatState, themeStore);
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

  Future<void> _onRefresh() {
    return _bloc.getKhatmat(isRefresh: true);
  }

  Widget _buildBody(
    BaseState state,
    AppThemeManager themeStore,
  ) {
    if (state is BaseFailState) {
      return AppErrorWidget(errorState: state);
    }
    if (state is KhatmatSuccess) {
      final khatmat = state.khatmat;
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  return KhatmaListItem(
                    khatma: khatmat[index],
                    onTap: () {
                      navigator.pushNamed(
                        Routes.khatmaDetailsScreen,
                        arguments: BaseNavigationArg(
                          data: khatmat[index],
                        ),
                      );
                    },
                  );
                },
                childCount: khatmat.length,
              ),
            ),
          ],
        ),
      );
    }
    return Center(child: AppLoader());
  }
}
