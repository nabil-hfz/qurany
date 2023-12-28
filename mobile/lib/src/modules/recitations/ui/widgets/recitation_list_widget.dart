import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kawtharuna/src/core/widgets/loader/app_loading_indicator.dart';
import 'package:kawtharuna/src/modules/recitations/domain/blocs/recitation_cubit.dart';

class RecitationListWidget extends StatelessWidget {
  const RecitationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecitationCubit, RecitationState>(
      builder: (ctx, state) {
        return AppLoader();
      },
    );
  }
}
