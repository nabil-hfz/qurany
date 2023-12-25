import 'dart:async';

import 'package:flutter/foundation.dart';

/// This class would be used to search case delaying..
///
/// ```
/// Debouncer _debouncer = Debouncer(milliseconds: 1000);
///
///
/// void _getSearch(String query) {
///   _debouncer.run(() => callFunctionOn(query));
/// }
/// ```

class Debouncer {
  final int milliseconds;
  final VoidCallback action;
  Timer? _timer;

  Debouncer({
    required this.milliseconds,
    required this.action,
  });

  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
