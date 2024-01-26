import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_state.dart';
import 'package:kawtharuna/src/core/constants/app_enums.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/error/app_error_widget.dart';
import 'package:kawtharuna/src/core/widgets/loader/app_loading_indicator.dart';
import 'package:kawtharuna/src/modules/recitations/domain/blocs/recitation_cubit.dart';
import 'package:kawtharuna/src/modules/recitations/domain/entity/recitation_entity.dart';

import 'recitation_list_time_widget.dart';

class RecitationListWidget extends StatefulWidget {
  final bool isSliverList;
  final int? khatmaId;
  final int? reciterId;

  const RecitationListWidget._({
    this.isSliverList = true,
    this.khatmaId,
    this.reciterId,
  }) : assert(khatmaId != null || reciterId != null);

  factory RecitationListWidget.sliver({
    int? khatmaId,
    int? reciterId,
  }) {
    return RecitationListWidget._(
      khatmaId: khatmaId,
      reciterId: reciterId,
    );
  }

  factory RecitationListWidget.normal({
    int? khatmaId,
    int? reciterId,
  }) {
    return RecitationListWidget._(
      isSliverList: false,
      khatmaId: khatmaId,
      reciterId: reciterId,
    );
  }

  @override
  State<RecitationListWidget> createState() => _RecitationListWidgetState();
}

class _RecitationListWidgetState extends State<RecitationListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecitationCubit, RecitationState>(
      bloc: findDep<RecitationCubit>(),
      builder: (ctx, state) {
        final resultState = state.getRecitations;
        return _buildBod(resultState);
      },
    );
  }

  Widget _buildBod(BaseState state) {
    if (state is RecitationsSuccess) {
      final recitations = state.recitations;
      return _buildListOrGrid(recitations);
    }

    Widget child;
    if (state is BaseFailState) {
      child = AppErrorWidget(errorState: state);
    } else {
      child = AppLoader();
    }
    return SliverToBoxAdapter(child: child);
  }

  Widget _buildListOrGrid(List<RecitationEntity> recitations) {
    final width = DeviceUtils.getScaledWidth(context, 1);
    final height = DeviceUtils.getScaledHeight(context, 1);
    final size = min(width, height);

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (isPortrait) {
      if (size <= AppConstants.mobileThreshold) {
        return SliverList.builder(
          itemBuilder: (ctx, index) {
            return RecitationListItem(
              index: index,
              recitation: recitations[index],
            );
          },
          itemCount: recitations.length,
        );
      }
    }
    int crossAxisCount = width <= AppConstants.desktopThreshold ? 2 : 3;
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (ctx, index) {
          return RecitationListItem(
            index: index,
            recitation: recitations[index],
          );
        },
        childCount: recitations.length,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 1.8,
      ),
    );
  }
}
