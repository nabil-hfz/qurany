import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/app_bar/empty_app_bar_widget.dart';
import 'package:kawtharuna/src/modules/khatmat/domain/entity/khatma_entity.dart';
import 'package:kawtharuna/src/modules/khatmat/ui/widgets/katma_list_time.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          // title: AppUtils.localizedPlatform(context, widget.args.name),
          ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: KhatmaListItem(
              khatma: widget.args,
            ),
          )
        ],
      ),
    );
  }
}
