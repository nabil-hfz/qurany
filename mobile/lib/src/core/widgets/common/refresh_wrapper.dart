// Dart imports:
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:kawtharuna/src/core/constants/app_animation_duration.dart';
import 'package:kawtharuna/src/core/managers/managers.dart';
import 'package:kawtharuna/src/core/models/result.dart';
import 'package:kawtharuna/src/core/utils/utils_collection.dart';
import 'package:kawtharuna/src/core/widgets/loader/app_loading_indicator.dart';

// Package imports:
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshWrapper extends StatefulWidget {
  final Widget child;

  final bool? primary;
  final bool enablePullUp;
  final bool enablePullDown;
  final bool withInitialRefresh;
  final double? offset;
  final Axis? scrollDirection;
  final ScrollPhysics? physics;
  final Future Function(RefreshControllerHandler)? onRefresh;
  final Future Function(RefreshControllerHandler)? onLoading;
  final Future Function(RefreshControllerHandler controller)?
      onControllerInitiated;

  const RefreshWrapper({
    super.key,
    required this.child,
    this.onRefresh,
    this.onLoading,
    this.withInitialRefresh = true,
    this.enablePullUp = true,
    this.enablePullDown = true,
    this.primary,
    this.offset,
    this.physics,
    this.scrollDirection,
    this.onControllerInitiated,
  });

  @override
  State<RefreshWrapper> createState() => _RefreshWrapperState();
}

class _RefreshWrapperState extends State<RefreshWrapper> {
  late RefreshControllerHandler _refreshControllerHandler;

  ValueNotifier<bool> forFirstTime = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _refreshControllerHandler = RefreshControllerHandler(
      controller: RefreshController(initialRefresh: false),
      scrollController: ScrollController(),
    );

    if (widget.onControllerInitiated != null) {
      widget.onControllerInitiated!(_refreshControllerHandler);
    }
    if (widget.withInitialRefresh && widget.onRefresh != null) {
      widget.onRefresh!(_refreshControllerHandler);
    }
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   if (widget.withInitialRefresh) {
    //     _refreshControllerHandler.controller.requestRefresh();
    //   }
    //   if (widget.onControllerInitiated != null) {
    //     widget.onControllerInitiated!(_refreshControllerHandler);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    AppThemeManager themeStore = Provider.of<AppThemeManager>(context);
    return SmartRefresher(
      scrollDirection: widget.scrollDirection,
      enablePullDown: widget.enablePullDown,
      enablePullUp: widget.enablePullUp,
      onRefresh: () {
        if (widget.onRefresh != null) {
          widget.onRefresh!(_refreshControllerHandler);
        }
      },
      onLoading: () {
        if (widget.onLoading != null) {
          widget.onLoading!(_refreshControllerHandler);
        }
      },
      physics: widget.physics,
      controller: _refreshControllerHandler.controller,
      scrollController: _refreshControllerHandler.scrollController,
      header: MaterialClassicHeader(
        backgroundColor: themeStore.appColors.refreshHeaderColor,
        offset: widget.offset ?? 0,
        height: 50,
      ),
      footer: const AppLoadingFooter(),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _refreshControllerHandler.dispose();
    forFirstTime.dispose();
    super.dispose();
  }
}

class RefreshControllerHandler {
  final RefreshController controller;
  final ScrollController? scrollController;

  const RefreshControllerHandler({
    required this.controller,
    this.scrollController,
  });

  void _loadFailed() {
    controller.loadFailed();
  }

  void _loadNoData() {
    controller.loadNoData();
  }

  void _loadCompleted() {
    controller.loadComplete();
  }

  void _refreshCompleted() {
    controller.refreshCompleted();
    try {
      scrollController?.position.animateTo(
        0,
        duration: const Duration(
          milliseconds: AppDuration.mediumAnimationDuration,
        ),
        curve: Curves.easeInOut,
      );
    } catch (_) {}
  }

  void _refreshIdle() {
    controller.refreshToIdle();
  }

  void _requestRefresh() {
    controller.requestRefresh();
  }

  void resetStatus() {
    controller.resetNoData();
  }

  /// This method will handle the state of the result
  /// and reflect the corresponding state to [controller]
  void handle(Result<List<dynamic>> result, {int? pageIndex}) {
    appPrint('handle current pageIndex is: $pageIndex');

    if (result.hasDataOnly) {
      appPrint('RefreshControllerHandler Current request: hasDataOnly');
      final data = result.data!;
      if (data.isEmpty) {
        appPrint('RefreshControllerHandler Current list: empty');
        if (pageIndex == 0) {
          controller.resetNoData();
        } else {
          _loadNoData();
        }
      } else {
        appPrint('RefreshControllerHandler Current list: not empty');
        _loadCompleted();
      }
      _refreshCompleted();
    } else {
      errorHappened();
    }
  }

  /// This method will handle the state of the result
  /// and reflect the corresponding state to [controller]
  Future<void> handleStream(
    Result<Stream<List<dynamic>>> result, {
    int? pageIndex,
  }) async {
    appPrint('handleStream current pageIndex is: $pageIndex');
    try {
      if (result.hasDataOnly) {
        appPrint(
            'RefreshControllerHandler Current request: hasDataOnly ${result.data}');
        final data = result.data;
        final ans = (await data?.last)?.isEmpty ?? true;
        appPrint('RefreshControllerHandler Current list: isEmpty $ans');
        if (ans) {
          appPrint('RefreshControllerHandler Current list: empty');
          if (pageIndex == 0) {
            controller.resetNoData();
          } else {
            _loadNoData();
          }
        } else {
          appPrint('RefreshControllerHandler Current list: not empty');
          _loadCompleted();
        }
        _refreshCompleted();
      } else {
        errorHappened();
      }
      appPrint('RefreshControllerHandler finished handleStream function');
    } catch (err, stackTrace) {
      appPrint(
          'RefreshControllerHandler error happened err: $err stackTrace is $stackTrace');
      errorHappened();
    }
  }

  /// This method will handle the state of the result
  /// and reflect the corresponding state to [controller]
  void handleList(List<dynamic>? result, {int? pageIndex}) {
    appPrint('handleList current pageIndex is: $pageIndex');

    if (result != null) {
      appPrint('RefreshControllerHandler Current request: hasDataOnly');
      if (result.isEmpty) {
        appPrint('RefreshControllerHandler Current list: empty');
        if (pageIndex == 0) {
          controller.resetNoData();
        } else {
          _loadNoData();
        }
      } else {
        appPrint('RefreshControllerHandler Current list: not empty');
        _loadCompleted();
      }
      _refreshCompleted();
    } else {
      errorHappened();
    }
  }

  void handleCustomResult(Result<dynamic> result, List<dynamic>? items,
      {int? pageIndex}) {
    appPrint('RefreshControllerHandler Empty Data');
    if (result.hasDataOnly) {
      handle(Result(data: items), pageIndex: pageIndex);
    } else {
      _loadFailed();
      _refreshIdle();
    }
  }

  void dispose() {
    controller.dispose();
    // if (scrollController?.hasListeners ?? false) {}
    scrollController?.dispose();
  }

  void errorHappened() {
    appPrint('RefreshControllerHandler errorHappened');
    _loadFailed();
    _refreshIdle();
  }

  void requestRefresh() {
    appPrint('RefreshControllerHandler requestRefresh');
    _requestRefresh();
  }

  void refreshIdle() {
    appPrint('RefreshControllerHandler refreshIdle');
    _refreshIdle();
  }
}

class AppLoadingFooter extends LoadIndicator {
  /// a builder for re wrap child,If you need to change the boxExtent or background,padding etc.you need outerBuilder to reWrap child
  /// example:
  /// ```dart
  /// outerBuilder:(child){
  ///    return Container(
  ///       color:Colors.red,
  ///       child:child
  ///    );
  /// }
  /// ````
  /// In this example,it will help to add backgroundColor in indicator
  final OuterBuilder? outerBuilder;

  final Widget? idleIcon, loadingIcon, noMoreIcon, failedIcon, canLoadingIcon;

  /// icon and text middle margin
  final double spacing;

  final IconPosition iconPos;

  final TextStyle textStyle;

  /// notice that ,this attrs only works for LoadStyle.ShowWhenLoading
  final Duration completeDuration;

  const AppLoadingFooter({
    super.key,
    super.onClick,
    super.loadStyle,
    super.height,
    this.outerBuilder,
    this.textStyle = const TextStyle(color: Colors.grey),
    this.noMoreIcon,
    this.failedIcon = const Icon(Icons.error, color: Colors.grey),
    this.iconPos = IconPosition.left,
    this.spacing = 15.0,
    this.completeDuration = const Duration(milliseconds: 300),
    this.loadingIcon,
    this.canLoadingIcon = const Icon(Icons.autorenew, color: Colors.grey),
    this.idleIcon = const Icon(Icons.arrow_upward, color: Colors.grey),
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _AppLoadingFooterState();
  }
}

class _AppLoadingFooterState extends LoadIndicatorState<AppLoadingFooter> {
  Widget _buildText(LoadStatus? mode) {
    final String idleText = translate.idle_loading_text,
        loadingText = translate.loading_text,
        noDataText = '', //translate.no_more_data_text,
        failedText = translate.load_failed_text,
        canLoadingText = translate.can_loading_text;
    return Text(
        mode == LoadStatus.loading
            ? loadingText
            : LoadStatus.noMore == mode
                ? noDataText
                : LoadStatus.failed == mode
                    ? failedText
                    : LoadStatus.canLoading == mode
                        ? canLoadingText
                        : idleText,
        style: widget.textStyle);
  }

  Widget _buildIcon(LoadStatus? mode) {
    Widget? icon = mode == LoadStatus.loading
        ? widget.loadingIcon ??
            const SizedBox(
              width: 25.0,
              height: 25.0,
              child: AppLoader(
                size: AppLoaderSize.tiny,
              ),
            )
        : mode == LoadStatus.noMore
            ? null
            : mode == LoadStatus.failed
                ? widget.failedIcon
                : mode == LoadStatus.canLoading
                    ? widget.canLoadingIcon
                    : widget.idleIcon;
    return icon ?? Container();
  }

  @override
  Future endLoading() {
    // TODO: implement endLoading
    return Future.delayed(widget.completeDuration);
  }

  @override
  Widget buildContent(BuildContext context, LoadStatus? mode) {
    // TODO: implement buildChild
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    List<Widget> children = <Widget>[iconWidget, textWidget];
    final Widget container = Wrap(
      spacing: widget.spacing,
      textDirection: widget.iconPos == IconPosition.left
          ? TextDirection.ltr
          : TextDirection.rtl,
      direction: widget.iconPos == IconPosition.bottom ||
              widget.iconPos == IconPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: widget.iconPos == IconPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      alignment: WrapAlignment.center,
      children: children,
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder!(container)
        : SizedBox(
            height: widget.height,
            child: Center(
              child: container,
            ),
          );
  }
}
