// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:kawtharuna/src/core/helpers/hlp_shared_preference.dart' as _i7;
import 'package:kawtharuna/src/core/managers/localization/app_language.dart'
    as _i8;
import 'package:kawtharuna/src/core/managers/navigation/app_navigator.dart'
    as _i3;
import 'package:kawtharuna/src/core/managers/network/dio_client.dart' as _i11;
import 'package:kawtharuna/src/core/managers/theme/app_them_manager.dart'
    as _i9;
import 'package:kawtharuna/src/modules/reciter/data/datasource/reciter_local_data_source_impl.dart'
    as _i5;
import 'package:kawtharuna/src/modules/reciter/data/datasource/reciter_remote_data_source_impl.dart'
    as _i12;
import 'package:kawtharuna/src/modules/reciter/domain/blocs/reciters_cubit.dart'
    as _i14;
import 'package:kawtharuna/src/modules/reciter/domain/repo/service_repository_impl.dart'
    as _i13;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import 'module/local_module.dart' as _i15;
import 'module/network_module.dart' as _i16;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
Future<_i1.GetIt> init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final localModule = _$LocalModule();
  final serviceModule = _$ServiceModule();
  gh.singleton<_i3.AppNavigator>(_i3.AppNavigator());
  await gh.factoryAsync<_i4.InternetConnectionChecker>(
    () => localModule.checker,
    preResolve: true,
  );
  gh.singleton<_i5.ReciterLocalDataSource>(_i5.ReciterLocalDataSource());
  await gh.factoryAsync<_i6.SharedPreferences>(
    () => localModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i7.SharedPreferenceHelper>(
      _i7.SharedPreferenceHelper(gh<_i6.SharedPreferences>()));
  gh.singleton<_i8.AppLanguageManager>(
    _i8.AppLanguageManager(gh<_i7.SharedPreferenceHelper>()),
    dispose: (i) => i.disposeManager(),
  );
  gh.singleton<_i9.AppThemeManager>(
    _i9.AppThemeManager(gh<_i7.SharedPreferenceHelper>()),
    dispose: (i) => i.disposeManager(),
  );
  gh.lazySingleton<_i10.Dio>(
      () => serviceModule.getDio(gh<_i7.SharedPreferenceHelper>()));
  gh.factory<_i11.DioClient>(() => _i11.DioClient(gh<_i10.Dio>()));
  gh.singleton<_i12.ReciterRemoteDataSource>(
      _i12.ReciterRemoteDataSource(gh<_i11.DioClient>()));
  gh.singleton<_i13.ImplReciterRepository>(_i13.ImplReciterRepository(
    gh<_i4.InternetConnectionChecker>(),
    gh<_i12.ReciterRemoteDataSource>(),
    gh<_i5.ReciterLocalDataSource>(),
  ));
  gh.singleton<_i14.ReciterCubit>(
      _i14.ReciterCubit(gh<_i13.ImplReciterRepository>()));
  return getIt;
}

class _$LocalModule extends _i15.LocalModule {}

class _$ServiceModule extends _i16.ServiceModule {}
