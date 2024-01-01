import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/di/di.dart';
import 'package:kawtharuna/src/core/managers/audio/common.dart';
import 'package:kawtharuna/src/core/managers/localization/app_translation.dart';
import 'package:kawtharuna/src/core/widgets/app_bar/empty_app_bar_widget.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';
import 'package:kawtharuna/src/modules/khatmat/ui/widgets/katma_list_time.dart';
import 'package:kawtharuna/src/modules/recitations/domain/blocs/recitation_cubit.dart';
import 'package:kawtharuna/src/modules/recitations/ui/widgets/recitation_list_widget.dart';

class KhatmaDetailsScreen extends StatefulWidget {
  const KhatmaDetailsScreen({
    super.key,
    required this.args,
  });

  final KhatmaEntity args;

  @override
  State<KhatmaDetailsScreen> createState() => _KhatmaDetailsScreenState();
}

class _KhatmaDetailsScreenState extends State<KhatmaDetailsScreen> {
  final _cubit = findDep<RecitationCubit>();
  final CancelToken _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: true,
        title: translate.khatma_details,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: KhatmaListItem(
                khatma: widget.args,
              ),
            ),
            RecitationListWidget.sliver(
              khatmaId: widget.args.id,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  Future _onRefresh() {
    return _cubit.getRecitations(
      isRefresh: true,
      reciterId: widget.args.reciter?.id,
      khatmaId: widget.args.id,
      cancelToken: _cancelToken,
    );
  }
}
