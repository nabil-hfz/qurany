class AnalyticsManager {
  AnalyticsManager._internal();

  static final AnalyticsManager _instance = AnalyticsManager._internal();

  static AnalyticsManager get shared => _instance;

  factory AnalyticsManager() {
    return _instance;
  }

  /// todo : add Your Code for Analytics Here
}
