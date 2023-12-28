// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../../modules/khatmat/data/datasource/khatma_local_data_source_impl.dart'
    as _i5;
import '../../modules/khatmat/data/datasource/khatma_remote_data_source_impl.dart'
    as _i13;
import '../../modules/khatmat/domain/blocs/khatma_cubit.dart' as _i17;
import '../../modules/khatmat/domain/repo/khatma_repository_impl.dart' as _i15;
import '../../modules/reciter/data/datasource/reciter_local_data_source_impl.dart'
    as _i6;
import '../../modules/reciter/data/datasource/reciter_remote_data_source_impl.dart'
    as _i14;
import '../../modules/reciter/domain/blocs/reciter_cubit.dart' as _i18;
import '../../modules/reciter/domain/repo/reciter_repository_impl.dart' as _i16;
import '../helpers/hlp_shared_preference.dart' as _i8;
import '../managers/localization/app_language.dart' as _i9;
import '../managers/navigation/app_navigator.dart' as _i3;
import '../managers/network/dio_client.dart' as _i12;
import '../managers/theme/app_them_manager.dart' as _i10;
import 'module/local_module.dart' as _i19;
import 'module/network_module.dart' as _i20;

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
  gh.singleton<_i5.KhatmaLocalDataSource>(const _i5.KhatmaLocalDataSource());
  gh.singleton<_i6.ReciterLocalDataSource>(const _i6.ReciterLocalDataSource());
  await gh.factoryAsync<_i7.SharedPreferences>(
    () => localModule.prefs,
    preResolve: true,
  );
  gh.singleton<_i8.SharedPreferenceHelper>(
      _i8.SharedPreferenceHelper(gh<_i7.SharedPreferences>()));
  gh.singleton<_i9.AppLanguageManager>(
    _i9.AppLanguageManager(gh<_i8.SharedPreferenceHelper>()),
    dispose: (i) => i.disposeManager(),
  );
  gh.singleton<_i10.AppThemeManager>(
    _i10.AppThemeManager(gh<_i8.SharedPreferenceHelper>()),
    dispose: (i) => i.disposeManager(),
  );
  gh.lazySingletonAsync<_i11.Dio>(
      () => serviceModule.getDio(gh<_i8.SharedPreferenceHelper>()));
  gh.singletonAsync<_i12.DioClient>(
      () async => _i12.DioClient(await gh.getAsync<_i11.Dio>()));
  gh.singletonAsync<_i13.KhatmaRemoteDataSource>(() async =>
      _i13.KhatmaRemoteDataSource(await gh.getAsync<_i12.DioClient>()));
  gh.singletonAsync<_i14.ReciterRemoteDataSource>(() async =>
      _i14.ReciterRemoteDataSource(await gh.getAsync<_i12.DioClient>()));
  gh.singletonAsync<_i15.ImplKhatmaRepository>(
      () async => _i15.ImplKhatmaRepository(
            gh<_i4.InternetConnectionChecker>(),
            await gh.getAsync<_i13.KhatmaRemoteDataSource>(),
            gh<_i5.KhatmaLocalDataSource>(),
          ));
  gh.singletonAsync<_i16.ImplReciterRepository>(
      () async => _i16.ImplReciterRepository(
            gh<_i4.InternetConnectionChecker>(),
            await gh.getAsync<_i14.ReciterRemoteDataSource>(),
            gh<_i6.ReciterLocalDataSource>(),
          ));
  gh.singletonAsync<_i17.ReciterCubit>(() async =>
      _i17.ReciterCubit(await gh.getAsync<_i16.ImplReciterRepository>()));
  gh.singletonAsync<_i18.ReciterCubit>(() async =>
      _i18.ReciterCubit(await gh.getAsync<_i16.ImplReciterRepository>()));
  return getIt;
}

class _$LocalModule extends _i19.LocalModule {}

class _$ServiceModule extends _i20.ServiceModule {}
