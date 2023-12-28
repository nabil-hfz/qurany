// Flutter imports:
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/bloc/base/states/base_fail_state.dart';
import 'package:kawtharuna/src/core/widgets/error/custom_error_widget.dart';

class AppErrorWidget extends StatefulWidget {
  final Widget? body;
  final BaseFailState? errorState;
  final String? message;

  const AppErrorWidget({
    super.key,
    this.message,
    this.body,
    this.errorState,
  });

  @override
  _AppErrorWidgetState createState() => _AppErrorWidgetState();
}

class _AppErrorWidgetState extends State<AppErrorWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomErrorWidget(
      callback: widget.errorState?.callback,
      error: widget.errorState?.error,
    );
    // return Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: <Widget>[
    //       widget.body ?? Container(),
    //       const Padding(
    //         padding: EdgeInsets.all(AppDimens.space12),
    //         child: Text(
    //           'widget.message',
    //         ),
    //       ),
    //       if (widget.callback != null)
    //         BouncingButton(
    //           text: translate.retry,
    //           onPressed: () {
    //             widget.callback!();
    //           },
    //         ),
    //     ],
    //   ),
    // );
  }
}
