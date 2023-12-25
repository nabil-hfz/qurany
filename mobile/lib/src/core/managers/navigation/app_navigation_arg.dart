class BaseNavigationArg {
  BaseNavigationArg({this.navigationType, this.data});

  final NavigationType? navigationType;
  final Object? data;
}

enum NavigationType {
  /// this just applied to two pages
  slid,
  slideHorizontal,
  slideVertical,
  scale,
  fade,

  /// this just applied to the new screen
  fadeScale,
}
