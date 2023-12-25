import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:kawtharuna/src/core/managers/navigation/app_navigator.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() async => await init(getIt);

Dep findDep<Dep extends Object>({String? instanceName}) {
  if (instanceName?.isNotEmpty ?? false) getIt<Dep>(instanceName: instanceName);
  return getIt<Dep>();
}

AppNavigator get navigator {
  return findDep<AppNavigator>();
}
